extends ProgressBar
# Default starting percent
var percent = 100;

# Called when the node enters the scene tree for the first time.
func _ready():
	value = percent;
	# hide();

func _show_bar():
	show();

func _process(delta):
	# Each frame change bar value to the percent
	value = percent;
