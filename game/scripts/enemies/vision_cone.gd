extends Node2D
	
enum DIRECTION {
	CLOCKWISE = 1,
	COUNTER_CLOCKWISE = -1
}

export var MIN_ROTATION_THRESHOLD = -45
export var MAX_ROTATION_THRESHOLD = 45

var scan_speed:float = 30
var scan_direction = DIRECTION.CLOCKWISE

func _ready():
	rotation_degrees = MIN_ROTATION_THRESHOLD


func _physics_process(delta):
	rotation_degrees += scan_speed * scan_direction * delta
	
	if rotation_degrees >= MAX_ROTATION_THRESHOLD:
		scan_direction = DIRECTION.COUNTER_CLOCKWISE
	elif rotation_degrees <= MIN_ROTATION_THRESHOLD:
		scan_direction = DIRECTION.CLOCKWISE
