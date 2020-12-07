extends KinematicBody2D

onready var navigation = get_tree().get_root().find_node("Navigation2D", true, false)
onready var destinations = navigation.get_node("Destinations")

const MAX_SPEED = 150
const ACCELERATION = 1500

var motion = Vector2.ZERO
#all destinations placed on map
var possible_destinations
##Array of vectors 
var path
##minimum distance in pixels to the destination point before youre considered ARRIVED
export var arrival_offset = 5
export var walk_speed = 0.5


func _ready():
	randomize()
	possible_destinations = destinations.get_children()
	print(possible_destinations)
	make_path()


func _physics_process(delta):
	navigate()


func navigate():
	var distance_to_sdestination = position.distance_to(path[0])
	#is he near the destination point 
	if distance_to_destination > arrival_offset:
		move()
	else:
		update_path()


#When the guard reaches one point in the path towards the destination this will 
#remove that path from the paths array
func update_path():
	#when the guard reaches the destination
	if path.size() == 1:
		if $MovementTimer.is_stopped():
			$MovementTimer.start()
			print("Timer Started Moving...")
	#if hes not there hes at a new point in the path
	else:
		path.remove(0)


func move():
	motion = (path[0] - position).normalized() * (MAX_SPEED * walk_speed)
	if motion.x < 0:
		$AnimatedSprite.play("walk_left")
	elif motion.x > 0:
		$AnimatedSprite.play("walk_right")
	elif motion.y < 0:
		$AnimatedSprite.play("walk_up")
	elif motion.y > 0:
		$AnimatedSprite.play("walk_down")
	else:
		$AnimatedSprite.play("idle")
	if is_on_wall():
		make_path()
	move_and_slide(motion)


#Generates a new path for the guard to take
func make_path():
	var new_destination = possible_destinations[randi() % possible_destinations.size() - 1]
	path = navigation.get_simple_path(position, new_destination.position, false)


func _on_MovementTimer_timeout():
	make_path()
