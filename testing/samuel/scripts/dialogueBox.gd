extends ColorRect

export var dialogPath = ""
# The smaller this value is, the faster text goes
export(float) var textSpeed = 0.07

var dialog

var phraseNum = 0
var finished = false

# Note: bold font currently has settings to be more spaced instead of bold, 
# and code text is simply smaller text size. This can be checked in the 2D inspector for text.

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set wait timer to equal to text speed
	$textShowTimer.wait_time = textSpeed
	# Set dialog to the array made from getting dialog
	dialog = getDialog()
	# assert(dialog, "Dialog not found")
	nextPhrase()

func getDialog() -> Array:
	var f = File.new()
	# assert(f.file_exists(dialogPath), "File path does not exist")
	f.open(dialogPath, File.READ)
	var json = f.get_as_text()
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []

func nextPhrase() -> void:
	# If there is no more dialogue, remove this node from tree
	if phraseNum >= len(dialog):
		queue_free()
		return
	# Sets the finished to false so the player pressing accept works as intended
	finished = false
	
	$speakerName.bbcode_text = dialog[phraseNum]["Name"]
	$speakerDialog.bbcode_text = dialog[phraseNum]["Text"]
	
	$speakerDialog.visible_characters = 0
	
	#Unimplemented portrait feature
	#var f = File.new()
	#var img = dialog[phraseNum]["Name"] + dialog[phraseNum]["Emotion"]
	#if f.file_exists(img):
		#$speakerPortrait.texture = load(img)
	#else:
		#$speakerPortrait.texture = null
	
	# While the visible characters is shorter than the length of the text, continuously show the
	# next character
	while $speakerDialog.visible_characters < len($speakerDialog.text):
		$speakerDialog.visible_characters += 1
		$textSound.play()
		
		$textShowTimer.start()
		# Makes sure each letter only appears after the timer runs out
		yield($textShowTimer, "timeout")
	
	# Once all text is shown, finished is set to true, and the phrase count (the current phrase
	# to be shown) moves forward by one.
	finished = true
	phraseNum += 1
	return
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# If the player presses accept, it will either move onto the next phrase or
	# skip to the end of current phrase if still not complete.
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			nextPhrase()
			$enterSound.play()
		else:
			$speakerDialog.visible_characters = len($speakerDialog.text)
			


