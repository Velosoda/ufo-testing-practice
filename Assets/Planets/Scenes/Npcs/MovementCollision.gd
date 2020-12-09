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

