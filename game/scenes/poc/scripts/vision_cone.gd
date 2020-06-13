extends Node2D
	
enum DIRECTION {
	CLOCKWISE = 1,
	COUNTER_CLOCKWISE = -1
}

var scan_speed:float = 30
var scan_direction = DIRECTION.CLOCKWISE
# var max_rotation_threshold = 

func _physics_process(delta):
	rotation_degrees += scan_speed * scan_direction * delta
	