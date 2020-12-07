extends Control

func _on_NewGameButton_pressed():
	get_tree().change_scene("res://Scenes/Game Menu/NewGame.tscn")


func _on_LoadGameButton_pressed():
	get_tree().change_scene("res://Scenes/Game Menu/LoadGameMenu.tscn")


func _on_OptionsButton_pressed():
	get_tree().change_scene("res://Scenes/Game Menu/OptionsMenu.tscn")


func _on_TestRoomButton_pressed():
	get_tree().change_scene("res://Scenes/SolarSystem/TestRoom.tscn")


func _on_QuitGameButton_pressed():
	get_tree().quit()


func _on_NewGameButton_mouse_entered():
	$"Hovered Description".text = "New Game: Start a new game"


func _on_LoadGameButton_mouse_entered():
	$"Hovered Description".text = "Load Game: Continue playing from a save file"


func _on_OptionsButton_mouse_entered():
	$"Hovered Description".text = "Options: Set the in game options"


func _on_TestRoomButton_mouse_entered():
	$"Hovered Description".text = "Test Room: I play here"


func _on_QuitGameButton_mouse_entered():
	$"Hovered Description".text = "Quit Game: Exits the game"



func _on_NewGameButton_mouse_exited():
	$"Hovered Description".text = ""


func _on_LoadGameButton_mouse_exited():
	$"Hovered Description".text = ""


func _on_OptionsButton_mouse_exited():
	$"Hovered Description".text = ""


func _on_TestRoomButton_mouse_exited():
	$"Hovered Description".text = ""


func _on_QuitGameButton_mouse_exited():
	$"Hovered Description".text = ""
