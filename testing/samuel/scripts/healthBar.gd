extends ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	value = 100
	# hide()

func _show_bar():
	show()

func _hide_bar():
	hide()
#func _process(delta):

func _on_decreaseHealth5_pressed():
	value -= 5

func _on_increaseHealth5_pressed():
	value += 5
