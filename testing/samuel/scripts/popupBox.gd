extends Panel

# The smaller this value is, the faster text goes
export(float) var textSpeed = 0.07

var dialog
var speakerName
var shown = false
var finished = false
signal messageEnded
var end_dialogue = false

# Note: bold font currently has settings to be more spaced instead of bold, 
# and code text is simply smaller text size. This can be checked in the 2D inspector for text.

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set wait timer to equal to text speed
	$textShowTimer.wait_time = textSpeed

# Converts text into an array, which is used to show the letters one by one
func getDialog(_name, text) -> Array:
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
	# If there is currently a box shown, yield showing text until the current one has ended
	if shown == true:
		yield(self, "messageEnded")
		
	self.show()
	shown = true
	finished = false
	$speakerName.bbcode_text = name
	$speakerDialog.bbcode_text = text
	$speakerDialog.visible_characters = 0
	
	if name != null:
		$speakerPortrait.texture = load("res://testing/samuel/assets/" + str(name) + ".jpg")
	else:
		$speakerPortrait.texture = null

	# While the visible characters is shorter than the length of the text, continuously show the
	# next character
	while $speakerDialog.visible_characters < len($speakerDialog.text):
		$speakerDialog.visible_characters += 1
		$textSound.play()
		$textShowTimer.start()
		# Makes sure each letter only appears after the timer runs out
		yield($textShowTimer, "timeout")
		# Once all letters are shown, set finished to true
		if $speakerDialog.visible_characters >= (len($speakerDialog.text)):
			finished = true
			break

# Called every frame
func _process(_delta):
	# If the player presses accept, it will either move onto the next phrase or
	# skip to the end of current phrase if still not complete.
	if Input.is_action_just_pressed("ui_accept") or end_dialogue:
		if finished && shown:
			$enterSound.play()
			self.hide()
			finished = false
			shown = false
			emit_signal("messageEnded")
		elif shown:
			$speakerDialog.visible_characters = len($speakerDialog.text)
		else:
			pass
