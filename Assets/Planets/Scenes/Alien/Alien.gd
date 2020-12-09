extends KinematicBody2D

var directions = preload("res://Scenes/Alien/Direction_Interface.gd")
var bullet = preload("res://Scenes/Weapons/Bullets/PlayersBullet.tscn")

const MAX_SPEED = 100
const ACCELERATION = 1500

var motion = Vector2.ZERO


func _process(delta):
	get_mouse_direction()
	walk_animation_loop()
	movement_loop()
	
func _physics_process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

func movement_loop():
	var left = Input.is_action_pressed("left")
	var right = Input.is_action_pressed("right")
	var up = Input.is_action_pressed("up")
	var down = Input.is_action_pressed("down")
	
	motion.x = -int(left) + int(right)
	motion.y = (-int(up) + int(down)) / float(2)
	
	var movement_direction = motion.normalized() * MAX_SPEED
	move_and_slide(movement_direction, Vector2.ZERO)

func walk_animation_loop():
	var facing_direction = get_players_facing_direction()
	var movement_direction = get_players_movement_direction()
	var opposite_of_facing_direction = directions.get_opposite(facing_direction)
	
	if facing_direction == movement_direction:
		$AnimatedSprite.play("moving_"+facing_direction)
	elif movement_direction == opposite_of_facing_direction:
		$AnimatedSprite.play("moving_"+facing_direction, true)
	elif movement_direction == directions.NOT_MOVING and facing_direction != directions.NOT_MOVING:
		$AnimatedSprite.play("idle_"+facing_direction)
	elif movement_direction != facing_direction and movement_direction != opposite_of_facing_direction:
		$AnimatedSprite.play("moving_"+facing_direction)

func get_players_facing_direction():
	# N = -90 trigger points are -67.5 or -112.5
	# NE = -45 trigger points are -22.5 or -67.5
	# E = 0 trigger points are -22.5 or 22.5
	# SE = 45 trigger points are 22.5 or 67.5
	# S = 90 trigger points are 67.5 or 112.5
	# SW = 135 trigger points are 112.5 or 157.5
	# W = -180 trigger points are -157.5 or 157.5
	# NW = -135 trigger points are -157.5 or -112.5
	var facing_direction
	var mouse_direction = get_mouse_direction()
	if float(mouse_direction) <= -67.5 and float(mouse_direction) >= -112.5:
		$GunPointer/Gun.set_flip_v(false)
		facing_direction = directions.NORTH
		return facing_direction
	elif float(mouse_direction) <= -22.5 and float(mouse_direction) >= -67.5:
		$GunPointer/Gun.set_flip_v(false)
		facing_direction = directions.NORTHEAST
		return facing_direction
	elif float(mouse_direction) <= 22.5 and float(mouse_direction) >= -22.5:
		$GunPointer/Gun.set_flip_v(false)
		facing_direction = directions.EAST
		return facing_direction
	elif float(mouse_direction) >= 22.5 and float(mouse_direction) <= 67.5:
		$GunPointer/Gun.set_flip_v(false)
		facing_direction = directions.SOUTHEAST
		return facing_direction
	elif float(mouse_direction) >= 67.5 and float(mouse_direction) <= 112.5:
		$GunPointer/Gun.set_flip_v(true)
		facing_direction = directions.SOUTH
		return facing_direction
	elif float(mouse_direction) >= 112.5 and float(mouse_direction) <= 157.5:
		facing_direction = directions.SOUTHWEST
		$GunPointer/Gun.set_flip_v(true)
		return facing_direction
	elif float(mouse_direction) >= 157.5 or float(mouse_direction) <= -157.5:
		facing_direction = directions.WEST
		$GunPointer/Gun.set_flip_v(true)
		return facing_direction
	elif float(mouse_direction) >= -157.5 and float(mouse_direction) <= -112.5:
		facing_direction = directions.NORTHWEST
		$GunPointer/Gun.set_flip_v(true)
		return facing_direction
	else:
		facing_direction = directions.NOT_MOVING
		$GunPointer/Gun.set_flip_v(true)
		return facing_direction

func get_players_movement_direction():
	#switch
	var move_direction
	match motion:
		Vector2(0,-0.5):
			move_direction = directions.NORTH
			return move_direction
		Vector2(1,-0.5):
			move_direction = directions.NORTHEAST
			return move_direction
		Vector2(1,0):
			move_direction = directions.EAST
			return move_direction
		Vector2(1,0.5):
			move_direction = directions.SOUTHEAST
			return move_direction
		Vector2(0,0.5):
			move_direction = directions.SOUTH
			return move_direction
		Vector2(-1,0.5):
			move_direction = directions.SOUTHWEST
			return move_direction
		Vector2(-1,0):
			move_direction = directions.WEST
			return move_direction
		Vector2(-1,-0.5):
			move_direction = directions.NORTHWEST
			return move_direction
		Vector2.ZERO:
			move_direction = directions.NOT_MOVING
			return move_direction

func get_mouse_direction():
	var mouse_direction
	mouse_direction = (get_angle_to(get_global_mouse_position())/3.14)*180
	return mouse_direction

func shoot():
	var bullet_instance = bullet.instance()
	bullet_instance.position = $GunPointer.get_global_position()
	bullet_instance.rotation_degrees = $GunPointer.rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(bullet_instance.SPEED,0).rotated($GunPointer.rotation))
	get_tree().get_root().call_deferred("add_child", bullet_instance)
	$Recoil.play("shoot_recoil")
	
