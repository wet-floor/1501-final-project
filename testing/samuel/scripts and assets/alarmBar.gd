extends ProgressBar
# Default starting percent
var percent = 100;
# Minimum percent, need to be higher than this
var min_percent = 0;
# Max percent, need to be under this
var max_percent = 70;
var completion = 0;
# Marks each stage as complete so it doesn't run it multiple times
var stage1Complete = false;
var stage2Complete = false;
var stage3Complete = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	value = percent;
	$minMaxPath/minAwakeness.unit_offset = (0);
	$minMaxPath/maxAwakeness.unit_offset = (0.7);
	$awakenessTimer.start();
	# hide();
	
func _show_bar():
	show();

func _on_awakenessTimer_timeout():
	# Minus 1 percent every 1/5 of a second (timer timeout)
	if percent > 0:
		percent -= 1;
		
	# If the percent is in between max and min:
	if (percent <= max_percent && percent >= min_percent):
		completion += 2;
		if completion > 20 && completion < 60 && stage1Complete == false:
			stage1();
			stage1Complete = true;
		if completion > 60 && completion < 80 && stage2Complete == false:
			stage2();
			stage2Complete = true;
		if completion > 80 && completion < 100 && stage3Complete == false:
			stage3();
			stage3Complete = true;
	# If the completion of the level is 100:
	if completion >= 100:
		# Level ending code here
		print("win")
		pass
	# Print testing (delete when finished)
	print("percent: " + str(percent));
	print("completion: " + str(completion));
	print("max unit offset: " + str($minMaxPath/maxAwakeness.unit_offset))
	print("max percent: " + str(max_percent))
	print("")

func stage1():
	min_percent = 20
	max_percent = 60
	# Changes the markers
	$minMaxPath/minAwakeness.unit_offset = (0.2);
	$minMaxPath/maxAwakeness.unit_offset = (0.6);
	pass
	
func stage2():
	min_percent = 50
	max_percent = 80
	# Changes the markers
	$minMaxPath/minAwakeness.unit_offset = (0.5);
	$minMaxPath/maxAwakeness.unit_offset = (0.8);
	pass
	
func stage3():
	min_percent = 80
	max_percent = 100
	# Changes the markers
	$minMaxPath/minAwakeness.unit_offset = (0.8);
	$minMaxPath/maxAwakeness.unit_offset = (1);
	pass

func _process(delta):
	value = percent;

