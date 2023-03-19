extends ColorRect

# The smaller this value is, the faster text goes
export(float) var textSpeed = 0.07

var dialog
var speakerName
var shown = false
var finished = false
signal messageEnded

# Note: bold font currently has settings to be more spaced instead of bold, 
# and code text is simply smaller text size. This can be checked in the 2D inspector for text.

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set wait timer to equal to text speed
	$textShowTimer.wait_time = textSpeed

func getDialog(name, text) -> Array:
	if typeof(text) == TYPE_ARRAY:
		return text
	if typeof (text) == TYPE_STRING:
		var textAsArray = []
		for letter in text:
			textAsArray.append(letter)
		return textAsArray
	else:
		print("That is not a valid text (Likely an object or an int)")
		return text

func showText(name, text):
	# Sets the finished to false so the player pressing accept works as intended
	self.show()
	shown = true
	finished = false
	$speakerName.bbcode_text = name
	$speakerDialog.bbcode_text = text
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
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# If the player presses accept, it will either move onto the next phrase or
	# skip to the end of current phrase if still not complete.
	if Input.is_action_just_pressed("ui_accept"):
		if finished && shown:
			$enterSound.play()
			emit_signal("messageEnded")
			self.hide()
			shown = false
		else:
			$speakerDialog.visible_characters = len($speakerDialog.text)
			
