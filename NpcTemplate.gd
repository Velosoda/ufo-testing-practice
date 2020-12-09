extends Node2D
const MAX_HEALTH = 100
var current_health = MAX_HEALTH

func die():
	print("dead")
	queue_free()


func _on_Area2D_body_entered(body):
	if body.collision_layer == 2147483680:
		current_health -= body.DAMAGE
		body.remove_on_impact()
		if current_health <= 0:
			die()

