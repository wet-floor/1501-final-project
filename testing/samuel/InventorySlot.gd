extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var icon_texture 
var icon_size
onready var item_name
onready var selected = false
onready var true_name

# Called when the node enters the scene tree for the first time.
func _ready():
	if icon_texture != null:
		icon_size = icon_texture.get_size()
		var targetH = 10
		var targetW = 10
	
		var scale = Vector2((icon_size.x/(icon_size.x/targetW))/100, (icon_size.y/(icon_size.y/targetH))/100)
		$Icon/Sprite.texture = icon_texture
		$Icon/Sprite.scale = scale

func setName(name):
	true_name = str(name)
	
	var colon_index = true_name.find(":")
	
	if colon_index > 0:
		item_name = true_name.substr(0, colon_index)
	else:
		item_name = true_name

	# Removes all numbers and symbols from end of item name
	item_name = item_name.lstrip("{}|[]:<>?,./-=_+`~!@#$%^&*()1234567890")
	item_name = item_name.rstrip("{}|[]:<>?,./-=_+`~!@#$%^&*()1234567890")
	
	icon_texture = load("res://scenes/common/objects/" + str(item_name) + ".png")
	
	if icon_texture != null:
		icon_size = icon_texture.get_size()
		var targetH = 10
		var targetW = 10

		var scale = Vector2((icon_size.x/(icon_size.x/targetW))/100, (icon_size.y/(icon_size.y/targetH))/100)
		$Icon/Sprite.texture = icon_texture
		$Icon/Sprite.scale = scale

func getName():
	return str(true_name)

func changeSelected(player):
	var selectedIndex = player.get_currently_selected_index()
	if selectedIndex == -1:
		selected = false
	else:
		selected = (getName() == str(player.get_inventory()[selectedIndex]))
	if selected:
		$Highlight.show()
	else:
		$Highlight.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	changeSelected(get_node("tdPlayer"))
