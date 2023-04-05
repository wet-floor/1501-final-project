extends Node

# number flags
var pants = 0

# progression flags
var reached_max_pants = false

# temp flags
var first_check = false
var is_pants_checked = false
var all_finished = false

# conditions
export var pants_limit = 2

# fields
onready var laundry_basket = get_node("Laundry Basket")
onready var player = get_node("tdPlayer")
onready var dialogue_box = get_node("popupUI/popupBox")


func _ready():
	$popupUI.hide()
	dialogue_box.connect("messageEnded", self, "_on_dialogue_ended")
	laundry_basket.connect("eject", self, "_on_laundry_ejected")


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
				dialogue_box.showText("[color=white][center]You", "[color=white]No tissues here... I guess I'll just chuck it into the washing machine.[/color]")	


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
			dialogue_box.showText("[color=white][center]Washing Machine", "[color=white]Are you a coward? Why check every pair of pants?[/color]")	
			dialogue_box.showText("[color=white][center]Washing Machine", "[color=white]Just thrown 'em all in! Only COWARDS check every one![/color]")	
			reached_max_pants = true
		if laundry_basket.get_storage() == 0:
			all_finished = true
			dialogue_box.showText("[color=white][center]Washing Machine", "[color=white]Heh, believing me is clearly your problem.[/color]")	


func _on_dialogue_ended():
	if all_finished == true:
		get_tree().change_scene("res://scenes/levels/l1/l1-boss.tscn")


func _on_laundry_ejected():
	if !first_check:
		$popupUI.show()
		dialogue_box.showText("[color=white][center]You", "[color=white]Maybe I can press F to check if there are any tissues in those pockets.[/color]")	
		first_check = true
