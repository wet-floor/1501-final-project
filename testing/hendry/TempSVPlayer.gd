extends KinematicBody2D

export (int) var speed = 1200
export (int) var jump_speed = -1800
export (int) var gravity = 4000
export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25
export (int, 0, 200) var inertia = 100

onready var hand = get_node("Hand")
onready var inventory = get_node("Hand/Inventory")
onready var arm = get_node("Arm Collision")

var direct_range_objects = []
var charge_power = 0

export var suck_power = 30
export var shoot_strength = 1500

var sucking = false

export var default_charge_power = 1
export var charge_rate = 3.0

var released_object : RigidBody2D

var screensize

var velocity : Vector2 = Vector2.ZERO
var mouse

func get_input():
	var dir = 0
	if Input.is_action_pressed("player_right"):
		dir += 1
	if Input.is_action_pressed("player_left"):
		dir -= 1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	
	# aiming
	mouse = get_global_mouse_position()
	hand.look_at(mouse)
	arm.rotation = hand.rotation


func check_jump():
	var jump_pressed = Input.is_action_pressed("player_jump")
	var jump_just_pressed = Input.is_action_just_pressed("player_jump")
	var jump_stop = Input.is_action_just_released("player_jump")
	
	#Jump Physics
	if velocity.y > 0: #Player is falling
		velocity += Vector2.UP * (-2.81) * (1) #Falling action is faster than jumping action | Like in mario
		
	elif velocity.y < 0 && jump_stop: #Player is jumping 
		velocity += Vector2.UP * (-9.81) * (100) #Jump Height depends on how long you will hold key
		
	if is_on_floor():
		if jump_just_pressed: 
			velocity = Vector2.DOWN * jump_speed #Normal Jump action
			jump_stop = false


func _physics_process(delta):
	get_input()
	
	# sucking and shooting
	get_action(delta)
	
	screensize = get_viewport_rect().size
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	object_follow(delta)
	check_jump()
	
	# movement
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP, false, 10, PI/4, false)
	
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("body"):
			collision.collider.apply_central_impulse(-collision.normal * inertia)


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
			lerp(body.global_position, inventory.global_position, 80)
			# body.global_position = body.global_position.linear_interpolate(inventory.global_position, delta * 80)
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
	
