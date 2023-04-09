extends Control

func _ready():
	$levelSelectionPanel.hide()
	$pauseMenuVisual.hide()
	$pauseMenuVisual/SEVolume.hide()
	$pauseMenuVisual/MusicVolume.hide()
	$pauseMenuVisual/BackButtonVolume.hide()
	$pauseMenuVisual/MusicVolumeSlider.hide()
	$pauseMenuVisual/SEVolumeSlider.hide()


func _on_levelSelect_pressed():
	$levelSelectionPanel.show()
	$optionSelect.hide()
	
func _on_levelSelect1_pressed():
	get_tree().change_scene("res://scenes/levels/l1/l1-1.tscn")


func _on_levelSelect2_pressed():
	get_tree().change_scene("res://scenes/levels/l2/l2.tscn")


func _on_levelSelect3_pressed():
	get_tree().change_scene("res://scenes/levels/l3/l3-1.tscn")


func _on_levelSelect4_pressed():
	get_tree().change_scene("res://scenes/levels/l4/l4.1/l4-1.tscn")

func _on_backButton_pressed():
	$levelSelectionPanel.hide()
	$optionSelect.show()
	
func _on_optionSelect_pressed():
	$pauseMenuVisual.show()

func _on_VolumeButton_pressed():
	$pauseMenuVisual/VolumeButton.visible = !$pauseMenuVisual/VolumeButton.visible
	$pauseMenuVisual/MusicVolume.visible = !$pauseMenuVisual/MusicVolume.visible
	$pauseMenuVisual/SEVolume.visible = !$pauseMenuVisual/SEVolume.visible
	$pauseMenuVisual/BackButtonMain.visible = !$pauseMenuVisual/BackButtonMain.visible
	$pauseMenuVisual/BackButtonVolume.visible = !$pauseMenuVisual/BackButtonVolume.visible
	$pauseMenuVisual/MusicVolumeSlider.visible = !$pauseMenuVisual/MusicVolumeSlider.visible
	$pauseMenuVisual/SEVolumeSlider.visible = !$pauseMenuVisual/SEVolumeSlider.visible

func _on_BackButtonVolume_pressed():
	_on_VolumeButton_pressed()

func _on_MusicVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)

func _on_SEVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SE"), value)

func _on_BackButtonMain_pressed():
	$pauseMenuVisual.hide()
