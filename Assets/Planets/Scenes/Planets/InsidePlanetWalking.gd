extends Node2D

func _ready():
	Engine.set_target_fps(Engine.get_iterations_per_second())


func _on_TextureButton_pressed():
	get_tree().change_scene("res://Scenes/SolarSystem/TestRoom.tscn")
