extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var icon_texture 
var icon_size
onready var item_name
# Called when the node enters the scene tree for the first time.
func _ready():
	
	if icon_texture != null:
		icon_size = icon_texture.get_size()
		var targetH = 10
		var targetW = 10
	
		print(icon_size.x)
		print(icon_size.y)
		var scale = Vector2((icon_size.x/(icon_size.x/targetW))/100, (icon_size.y/(icon_size.y/targetH))/100)
		$Icon/Sprite.texture = icon_texture
		$Icon/Sprite.scale = scale

func setName(name):
	var emptyString = ""
	item_name = str(name)
	
	var item_name_array = []
	for c in item_name:
		item_name_array.append(c)
	
	# Remove last 19 letters of item name (which is usually ":RigidBody2D[1883]" or something)
	for i in range (19):
		item_name_array.pop_back()
	
	for i in item_name_array:
		emptyString += String(i)
		
	item_name = emptyString
	
	icon_texture = load("res://testing/samuel/assets/" + str(item_name) + ".png")
	
	if icon_texture != null:
		icon_size = icon_texture.get_size()
		var targetH = 10
		var targetW = 10
	
		print(icon_size.x)
		print(icon_size.y)
		var scale = Vector2((icon_size.x/(icon_size.x/targetW))/100, (icon_size.y/(icon_size.y/targetH))/100)
		$Icon/Sprite.texture = icon_texture
		$Icon/Sprite.scale = scale
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
