extends RigidBody2D

const INSTANCE_LIMIT = 100
const SPEED = 2000
const DAMAGE = 40


func _ready():
	$Timer.start()


func _on_Timer_timeout():
	queue_free()
	
func remove_on_impact():
	queue_free()


func _on_Area2D_body_entered(body):
	print(body.collision_layer)
	if body.collision_layer == 8:
		queue_free()
