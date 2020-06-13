extends Node2D

enum LookDirection {
	LEFT,
	UP,
	RIGHT,
	DOWN
}

onready var vision_cone = $LookRotation

export(LookDirection) var look_direction = LookDirection.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready():
	match look_direction:
		LookDirection.LEFT:
			vision_cone.rotation_degrees = 180

		LookDirection.UP:
			vision_cone.rotation_degrees = -90

		LookDirection.RIGHT:
			vision_cone.rotation_degrees = 0

		LookDirection.DOWN:
			vision_cone.rotation_degrees = 90
