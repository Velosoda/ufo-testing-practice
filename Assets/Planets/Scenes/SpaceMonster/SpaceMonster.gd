extends Node2D





func _on_Area2D_body_entered(body):
	print("passed through enemy")
	$Path2D/PathFollow2D/Area2D/Label.text = "Hey man whats up!"


func _on_Area2D_body_exited(body):
	$Path2D/PathFollow2D/Area2D/Label.text = ""
