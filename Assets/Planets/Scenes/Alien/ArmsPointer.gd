extends Node2D

func _process(delta):
	look_at(get_global_mouse_position())
	var mouse_direction
	mouse_direction = (get_angle_to(get_global_mouse_position())/3.14)*180
	if mouse_direction == 0:
		print("flip")
	return mouse_direction
