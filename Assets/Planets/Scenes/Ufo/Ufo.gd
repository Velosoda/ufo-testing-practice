extends KinematicBody2D


const MAX_SPEED = 500
const ACCELERATION = 2000
var motion = Vector2.ZERO
const DECELERATION = 100


#Vector2.zero is like an analog stick in center

func _physics_process(delta):
	var axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction(DECELERATION * delta)
	else:
		apply_movement(axis * ACCELERATION * delta)
	motion = move_and_slide(motion)


func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	axis.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	#wont move faster at diagonals
	return axis.normalized()
	
func apply_friction(reverse_force):
	if motion.length() > reverse_force:
		motion -= motion.normalized() * reverse_force
	else:
		$AnimatedSprite.play("idle")
		motion = Vector2.ZERO

func apply_movement(acceleration):
	#moving right
	if Input.is_action_pressed("right") == true:
		$AnimatedSprite.set_flip_h(true)
		$AnimatedSprite.play("flying")
	#moving left
	elif Input.is_action_pressed("left") == true:
		$AnimatedSprite.set_flip_h(false)
		$AnimatedSprite.play("flying")
	motion += acceleration
	motion = motion.clamped(MAX_SPEED)
###doing things here 
