extends Path2D

export (PackedScene) var alarmNote_scene
var noteCount = 0
var wasAlreadyTouched = false
func _ready():
	$spawnTimer.start()

func _on_spawnTimer_timeout():
	var note_spawn_location = $PathFollow2D
	note_spawn_location.unit_offset = randf()
	
	if noteCount <= 5:
		var note = alarmNote_scene.instance()
		add_child(note)
		noteCount += 1
	
		note.position = note_spawn_location.position
	
		var direction = note_spawn_location.rotation + PI / 2

		direction += rand_range(-PI / 8, PI / 8)
	
		var velocity = Vector2(150, 0)
	
		note.linear_velocity = velocity.rotated(direction)
	
		var alarmBar = get_node("alarmBar")
		note.connect("noteExited", self, "reduceNoteCount")
		note.connect("noteTouched", alarmBar, "_on_note_touched")
		note.connect("noteTouched", self, "_on_note_touched", [note])

func _process(_delta):
	$completionBar.value = $alarmBar.getCompletion()
	$completionBar/Label.text = str($completionBar.value) + "%"

func getNoteCount():
	return noteCount
	
func reduceNoteCount():
	noteCount -= 1

func _on_note_touched(note):
	if !note.getAlreadyTouched():
		note.linear_velocity = Vector2(0, 0)
		note.setAlreadyTouched(true)
	else:
		note.setAlreadyTouched(true)

