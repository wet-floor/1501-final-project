extends KinematicBody2D

export var speed = 1000
export var friction = 0.25
export var accel = 0.3
export var gravity = 5000
export var jumpSpeed = -1350
export var inertia = 100
export var direction = "left"

var motion = Vector2.ZERO

onready var hand = get_node("Hand")
onready var inventory = get_node("Hand/Inventory")
onready var arm = get_node("Hand/Range")
onready var charSprite = $Char

var direct_range_objects = []
var charge_power = 0

export var suck_power = 10
export var shoot_strength = 1

var sucking = false

export var default_charge_power = 1
export var charge_rate = 1.0

var released_object : RigidBody2D

var screensize

var current_scale
var mouse

# first run
func _ready():
	screensize = get_viewport_rect().size
	current_scale = $Char.get_scale()
	

## player shmoovement 
func get_input():
	var input_dir = 0

	if Input.is_action_pressed("player_right"):
		input_dir += 1
	
	if Input.is_action_pressed("player_left"):
		input_dir -= 1
		
	if input_dir != 0:
		motion.x = lerp(motion.x, input_dir * speed, accel)
	else:
		motion.x = lerp(motion.x, 0, friction)
	
	if Input.is_action_pressed("player_jump"):
		if is_on_floor():
			motion.y = jumpSpeed
			
	
	#mouse lookie wookie
	mouse = get_global_mouse_position()
	hand.look_at(mouse)
	arm.look_at(mouse)
	
	#character flippy wippy
	if mouse.x < position.x:
		charSprite.scale.x = -abs(current_scale.x)
		direction = "left"
	else:
		charSprite.scale.x = abs(current_scale.x)
		direction = "right"

func _physics_process(delta):
	get_input()
	
	#gravity constant 
	#god i fucking forgot a plus sign here and it took me an hour to figure out
	motion.y = motion.y + gravity * delta
	motion = move_and_slide(motion, Vector2.UP, false, 15, PI/3, false)
	
	#i think this is the for loop thing you mentioned in the meeting, tried to implement it here so it slows
	for index in get_slide_count():
		var collide = get_slide_collision(index)
		if collide.collider.is_in_group("body"):
			collide.collider.apply_central_impulse(-collide.normal * inertia)
	
	# sucking and shooting
	get_action(delta)
	
	screensize = get_viewport_rect().size
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	object_follow(delta)

func get_action(delta):
	if Input.is_action_pressed("player_suck"):
		suck()
	else:
		sucking = false
	
	if Input.is_action_pressed("player_shoot"):
		charge_shot(delta)
		
	if Input.is_action_just_released("player_shoot"):
		shoot()
		

func suck():
	if inventory.get_current_item() == null:
		sucking = true
		# print(sucking)
		for body in direct_range_objects:
			var suck_impulse = (inventory.global_position - body.global_position).normalized() * suck_power
			body.apply_central_impulse(suck_impulse)
			
			if body.is_in_group("container"):
				body.eject(global_position)
	else:
		sucking = false


func charge_shot(delta):
	if inventory.get_current_item() != null:
		charge_power += charge_rate * delta
		charge_power = clamp(charge_power, 0, 1)
		
	pass


func shoot():
	if inventory.get_current_item() != null:
		
		released_object = null
		
		# if the charge power is super small, assume the default value
		if charge_power <= 0.2:
			charge_power = default_charge_power
	
	
		released_object = inventory.get_current_item()
		
		print(charge_power)
		var shoot_impulse = (get_global_mouse_position() - inventory.global_position).normalized()
		shoot_impulse = shoot_impulse * shoot_strength * charge_power 
		
		inventory.release_item()
		released_object.apply_central_impulse(shoot_impulse)
		
		charge_power = 0  # reset the charge power back to 0 after shooting
		print(inventory.get_inventory())


func object_follow(delta):
	for item in inventory.get_inventory():
		if item != null:
			var body : RigidBody2D = item
			body.global_position = body.global_position.linear_interpolate(inventory.global_position, delta * 80)
			body.global_rotation = inventory.global_rotation

func get_inventory():
	return inventory.get_inventory()


func get_currently_selected_index():
	return inventory.get_currently_selected_index()


## SIGNALS
func _on_Direct_Range_body_entered(body):
	if body.is_in_group("body"):
		direct_range_objects.append(body)


func _on_Direct_Range_body_exited(body):
	if body.is_in_group("body"):
		direct_range_objects.erase(body)


func _on_Inventory_body_entered(body):
	if sucking and inventory.get_current_item() == null:
		if body.is_in_group("object"):
			inventory.add_item(body)
			print(inventory.get_inventory())
	
