extends Node2D



func _on_Area2D_body_entered(body):
	print("passed through enemy")
	$Area2D/Label.text = "MUAHHHHAHAHA!"
	get_tree().change_scene("res://Scenes/Planets/InsidePanetWalking.tscn")


func _on_Area2D_body_exited(body):
	$Area2D/Label.text = ""
