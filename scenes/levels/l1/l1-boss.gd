extends Node

# nodes
onready var boss = get_node("Boss")
onready var player = get_node("Player")

onready var boss_follow_path = get_node("BossFollowPath")
onready var boss_follow_location = get_node("BossFollowPath/BossFollowLocation")
onready var item_drop_path = get_node("ItemDropPath")
onready var item_spawn_location = get_node("ItemDropPath/ItemSpawnLocation")

onready var boss_animation_player = get_node("BossAnimationPlayer")

onready var dialogue_box = get_node("popupUI/popupBox")

onready var minThwompCooldown = get_node("MinThwompCooldown")
onready var maxThwompCooldown = get_node("MaxThwompCooldown")
onready var regretTickTime = get_node("Regret")

onready var dead_boss_position = get_node("DeadBossPosition")

export (Array, PackedScene) var falling_laundry
export (int) var laundry_damage

# fields
var player_position : Vector2
var boss_state : int
var regret_bar = 50
export (int, 1, 10) var min_item_drops
export (int, 1, 10) var max_item_drops
export (int) var washing_machine_damage


func _ready():
	Physics2DServer.area_set_param(get_viewport().get_world_2d().space, Physics2DServer.AREA_PARAM_GRAVITY_VECTOR, Vector2(0, 1))
	boss.set_state(boss.States.START)
	
	dialogue_box.connect("messageEnded", self, "_on_dialogue_ended")
	dialogue_box.showText("[color=white][center]Washing Machine", "It's [wave amp=30 freq=6][color=red]WASHING TIME.[/color][/wave]")	


func _physics_process(delta):
	player_position = player.global_position
	
	boss_state = boss.get_state()
	
	match boss_state:
		boss.States.START:
			boss_follow_location.unit_offset = 0.25  # brings laundry machine to the middle
			boss.global_position = lerp(boss.global_position, boss_follow_location.global_position, boss.move_speed * delta)

		boss.States.CHASE:
			boss_follow_location.offset = boss_follow_path.curve.get_closest_offset(player.global_position)
			boss.global_position = lerp(boss.global_position, boss_follow_location.global_position, boss.move_speed * delta)
			
			# does the washing machine want to thwomp?
			if maxThwompCooldown.is_stopped():
				boss.set_state(boss.States.THWOMP)
				maxThwompCooldown.stop()
				minThwompCooldown.stop()
			elif minThwompCooldown.is_stopped() and abs(boss.global_position.x - boss_follow_location.global_position.x) < 5:
				boss.set_state(boss.States.THWOMP)
				maxThwompCooldown.stop()
				minThwompCooldown.stop()
				
		boss.States.THWOMP:
			boss_follow_location.offset = boss_follow_path.curve.get_closest_offset(player.global_position)
			boss_animation_player.play("Thwomp")

		boss.States.PROJECTILE:
			pass
		
		boss.States.DEAD:
			boss.hide()
			boss.global_position = dead_boss_position.global_position

				
		
	if regret_bar >= 100:
		boss.set_state(boss.States.DEAD)
		print("boss dead")


func _on_Damage_body_entered(body):
	if body == player and boss.get_state() != boss.States.START:
		if regret_bar - washing_machine_damage <= 0:
			get_tree().reload_current_scene()
			return
		regret_bar -= washing_machine_damage
	
	elif body.is_in_group("laundry") and body.is_in_group("launched"):
		body.queue_free()
		
		if regret_bar + laundry_damage > 100:
			boss.set_state(boss.States.DEAD)
			dialogue_box.showText("[color=white][center]Washing Machine", "[wave amp=30 freq=6][color=white]NOOOOOOOOOOO[/color][/wave]")	
			return
		
		regret_bar += laundry_damage


func _on_dialogue_ended():
	if boss.state == boss.States.START:  # officially start the fight
		boss.set_state(boss.States.CHASE)
		minThwompCooldown.start()
		maxThwompCooldown.start()
		regretTickTime.start()
		$PreBossMusic.stop()
		$BossMusic.play()


func _on_BossAnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"Thwomp":
			boss.set_state(boss.States.CHASE)
			minThwompCooldown.start()
			maxThwompCooldown.start()


func _on_Regret_timeout():
	if boss.get_state() != boss.States.DEAD:
		regret_bar -= 1
	print(regret_bar)


func _on_landing():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	var item_drops = rng.randi_range(min_item_drops, max_item_drops)
	rng.randomize()
	
	for i in item_drops:
		item_spawn_location.unit_offset = rng.randf_range(0, 1)
		var falling_laundry_index = rng.randi_range(0, falling_laundry.size() - 1)
		var falling_laundry_instance = falling_laundry[falling_laundry_index].instance()
		
		falling_laundry_instance.global_position = item_spawn_location.global_position
		falling_laundry_instance.rotation_degrees = rng.randi_range(-180, 180)
		
		falling_laundry_instance.add_to_group("body")
		falling_laundry_instance.add_to_group("object")
		falling_laundry_instance.add_to_group("laundry")
		add_child(falling_laundry_instance)
