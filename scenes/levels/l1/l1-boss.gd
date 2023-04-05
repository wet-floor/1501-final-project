extends Node

# nodes
onready var boss = get_node("Boss")
onready var player = get_node("Player")
onready var boss_follow_path = get_node("BossFollowPath")
onready var boss_follow_location = get_node("BossFollowPath/BossFollowLocation")
onready var item_drop_path = get_node("ItemDropPath")
onready var item_spawn_location = get_node("ItemDropPath/ItemSpawnLocation")
onready var boss_animation_player = get_node("BossAnimationPlayer")

# fields
var player_position : Vector2
var boss_state : int
var regret_bar = 50

func _ready():
	Physics2DServer.area_set_param(get_viewport().get_world_2d().space, Physics2DServer.AREA_PARAM_GRAVITY_VECTOR, Vector2(0, 1))


func _physics_process(delta):
	player_position = player.global_position
	
	boss_state = boss.get_state()
	
	match boss_state:
		boss.States.CHASE:
			boss_follow_location.offset = boss_follow_path.curve.get_closest_offset(player.global_position)
			boss.global_position = lerp(boss.global_position, boss_follow_location.global_position, boss.move_speed * delta)
			
			# does the washing machine want to thwomp?
		boss.States.THWOMP:
			pass
		boss.States.PROJECTILE:
			pass


func _on_Damage_body_entered(body):
	if body == player:
		print("washing machine hit player")
		boss_animation_player.play("Thwomp")
		
