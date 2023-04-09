extends Control

var hehe

func _ready():
	# Hides every aspect of pause menu
	$pauseMenuVisual.hide()
	$pauseMenuVisual/SEVolume.hide()
	$pauseMenuVisual/MusicVolume.hide()
	$pauseMenuVisual/BackButtonVolume.hide()
	$pauseMenuVisual/MusicVolumeSlider.hide()
	$pauseMenuVisual/SEVolumeSlider.hide()
	
	# Sets pause menu pause mode to process
	# Copy this line into any other nodes that we don't want to pause while the game is paused
	pause_mode = Node.PAUSE_MODE_PROCESS

func _on_pauseButton_pressed():
	# Pause or unpause
	get_tree().paused = !get_tree().paused
	# Show or hide pause menu
	$pauseMenuVisual.visible = !$pauseMenuVisual.visible

func _on_VolumeButton_pressed():
	$pauseMenuVisual/VolumeButton.visible = !$pauseMenuVisual/VolumeButton.visible
	$pauseMenuVisual/MusicVolume.visible = !$pauseMenuVisual/MusicVolume.visible
	$pauseMenuVisual/SEVolume.visible = !$pauseMenuVisual/SEVolume.visible
	$pauseMenuVisual/BackButtonMain.visible = !$pauseMenuVisual/BackButtonMain.visible
	$pauseMenuVisual/BackButtonVolume.visible = !$pauseMenuVisual/BackButtonVolume.visible
	$pauseMenuVisual/MusicVolumeSlider.visible = !$pauseMenuVisual/MusicVolumeSlider.visible
	$pauseMenuVisual/SEVolumeSlider.visible = !$pauseMenuVisual/SEVolumeSlider.visible

func _on_BackButton_pressed():
	_on_pauseButton_pressed()

func _on_BackButtonVolume_pressed():
	_on_VolumeButton_pressed()

func _on_MusicVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)

func _on_SEVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SE"), value)

func _on_backToMenu_pressed():
	get_tree().change_scene("res://scenes/title/mainMenu.tscn")
