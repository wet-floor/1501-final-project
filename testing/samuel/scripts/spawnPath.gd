extends Path2D

export (PackedScene) var alarmNote_scene

func _ready():
	$spawnTimer.start()

func _on_spawnTimer_timeout():
	var note_spawn_location = $PathFollow2D
	note_spawn_location.unit_offset = randf()
	
	var note = alarmNote_scene.instance()
	add_child(note)
	
	note.position = note_spawn_location.position
	
	var direction = note_spawn_location.rotation + PI / 2

	direction += rand_range(-PI / 8, PI / 8)
	
	var velocity = Vector2(350, 0)
	
	note.linear_velocity = velocity.rotated(direction)
	
	var alarmBar = get_node("alarmBar")
	note.connect("noteTouched", alarmBar, "_on_note_touched")

func _process(delta):
	$completionBar.value = $alarmBar.getCompletion()
	$completionBar/Label.text = str($completionBar.value) + "%"
