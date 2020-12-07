extends Node

const NORTH = "north"
const NORTHEAST = "northeast"
const EAST = "east"
const SOUTHEAST = "southeast"
const SOUTH = "south"
const SOUTHWEST = "southwest"
const WEST = "west"
const NORTHWEST = "northwest"
const NOT_MOVING = "idle"

static func get_opposite(current_direction):
	match current_direction:
		NORTH:
			return SOUTH
		NORTHEAST:
			return SOUTHWEST
		EAST:
			return WEST
		SOUTHEAST:
			return NORTHWEST
		SOUTH:
			return NORTH
		SOUTHWEST:
			return NORTHEAST
		WEST:
			return EAST
		NORTHWEST:
			return SOUTHEAST





