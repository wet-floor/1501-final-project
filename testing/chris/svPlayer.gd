extends KinematicBody2D

export var speed = 500
export var friction = 0.2
export var acceleration = 0.4
export var gravity = 1000
export var jumpHeight = 100
export var jumpSpeed = 0
export var numJumps = 0

var input_dir = Vector2.ZERO

onready var hand = get_node("Hand")
onready var inventory = get_node("Hand/Inventory")

var direct_range_objects = []
var charge_power = 0

export var suck_power = 10
export var shoot_strength = 1

var sucking = false

export var default_charge_power = 1
export var charge_rate = 1.0

var released_object : RigidBody2D

var screensize


# first run
func _ready():
	screensize = get_viewport_rect().size

## PLAYER MOVEMENT 
func get_input():
	input_dir = Vector2.ZERO

	if Input.is_action_pressed("player_right"):
		input_dir.x += 1
	
	if Input.is_action_pressed("player_left"):
		input_dir.x -= 1
	
	if Input.is_action_pressed("player_jump"):
		if numJumps<1:
			jumpSpeed = -sqrt(jumpHeight * 2 * gravity)
			numJumps = 1
	
	input_dir = input_dir.normalized()

# PLAYER MOVE AND LOOK
func control():
	# apply gravity
	var gravity = Vector2(0, 1000)
	input_dir = move_and_slide_with_snap(input_dir * speed, Vector2(0, -1), gravity, false, 4, 0.785398, true)

## PLAYER ACTIONS
# get player input for sucking and shooting
func get_action(delta):
	if Input.is_action_pressed("player_suck"):
		suck()
	else:
		sucking = false
	
	if Input.is_action_pressed("player_shoot"):
		charge_shot(delta)
		
	if Input.is_action_just_released("player_shoot"):
		shoot()
	
	var mouse = get_global_mouse_position()
	
	# don't get the character confused with a close mouse distance
	if mouse.distance_to(self.position) > 50:
		look_at(get_global_mouse_position())
	
	# point the hand towards the mouse
	if mouse.distance_to(self.position) > 100:
		var hand_to_mouse_distance = hand.global_position.distance_to(mouse)
		var hand_to_body_distance = hand.global_position.distance_to(self.global_position)
		var hand_rotation = asin(hand_to_body_distance / hand_to_mouse_distance)
		hand.rotation = -hand_rotation
	pass


func suck():
	if inventory.get_current_item() == null:
		sucking = true
		# print(sucking)
		for body in direct_range_objects:
			var suck_impulse = (inventory.global_position - body.global_position).normalized() * suck_power
			body.apply_central_impulse(suck_impulse)
	else:
		sucking = false


func charge_shot(delta):
	if inventory.get_current_item() != null:
		charge_power += charge_rate * delta
		charge_power = clamp(charge_power, 0, 2)
		
	pass


func shoot():
	if inventory.get_current_item() != null:
		
		released_object = null
		
		# if the charge power is super small, assume the default value
		if charge_power <= 0.2:
			charge_power = default_charge_power
	
	
		var released_object : RigidBody2D = inventory.get_current_item()
		
		print(charge_power)
		var shoot_impulse = (get_global_mouse_position() - inventory.global_position).normalized()
		shoot_impulse = shoot_impulse * shoot_strength * charge_power 
		
		inventory.release_item()
		released_object.apply_central_impulse(shoot_impulse)
		
		charge_power = 0  # reset the charge power back to 0 after shooting
		print(inventory.get_inventory())


func get_inventory():
	return inventory.get_inventory()


func get_currently_selected_index():
	return inventory.get_currently_selected_index()
	
func object_follow(delta):
	for item in inventory.get_inventory():
		if item != null:
			var body : RigidBody2D = item
			body.global_position = body.global_position.linear_interpolate(inventory.global_position, delta * 40)
			body.global_rotation = inventory.global_rotation


## PROCESSING
func _physics_process(delta):
	
	# movement and look
	get_input()
	# Apply gravity
	jumpSpeed += gravity * delta
	if jumpSpeed > 750:
		jumpSpeed = 0
	print(jumpSpeed)
	if jumpSpeed == 0:
		numJumps = 0
	
	# Move character and detect collisions
	var velocity = Vector2(0, jumpSpeed)
	var collision = move_and_collide(velocity * delta)

	# If there was a collision, stop the jump
	if collision:
		jumpSpeed = 0
		
	control()
	
	# sucking and shooting
	get_action(delta)
	
	screensize = get_viewport_rect().size
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	object_follow(delta)
	


func _process(delta):
	pass

## SIGNALS
func _on_Direct_Range_body_entered(body):
	if body.is_in_group("object"):
		direct_range_objects.append(body)


func _on_Direct_Range_body_exited(body):
	if body.is_in_group("object"):
		direct_range_objects.erase(body)


func _on_Inventory_body_entered(body):
	if sucking and inventory.get_current_item() == null:
		inventory.add_item(body)
		print(inventory.get_inventory())
