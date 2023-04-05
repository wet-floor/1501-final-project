extends Node

# number flags
var pants = 0

# progression flags
var reached_max_pants = false

# temp flags
var is_pants_checked = false

# conditions
export var pants_limit = 2

# fields
onready var laundry_basket = get_node("Laundry Basket")
onready var player = get_node("tdPlayer")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()
	pass


func get_input():
	if Input.is_action_just_released("player_interact"):
		var player_selected_item = player.get_inventory()[player.get_currently_selected_index()]
		if player_selected_item == null:
			return
		if !reached_max_pants and player_selected_item.is_in_group("pants"):
			if !is_pants_checked:
				is_pants_checked = true
				print("no tissues here...")


func _on_Washing_Machine_Input_body_entered(body):
	if body.is_in_group("pants"):  # check if the body is actually pants
		print("pants collided with washing machine")
		if !reached_max_pants:  # if the washing machine hasn't called the player a coward yet
			if is_pants_checked:  # if the player actually checked the pants
				pants += 1
				body.queue_free()
				is_pants_checked = false
				laundry_basket.toggle_readiness(true)
			else:
				pass  # if the player didn't check the pants but before washing machine calls them a coward
		if reached_max_pants:  # if the washing machine already called a player a coward
			pants += 1
			body.queue_free()
			laundry_basket.toggle_readiness(true)
		print("pants: ", pants)
		if pants >= pants_limit and !reached_max_pants:
			print("reached max pants, washing machine now laughs at you")
			reached_max_pants = true
		if laundry_basket.get_storage() == 0:
			print("no more pants to put into the washing machine -- boss time")
