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
			print("look left, bro")
			vision_cone.rotation_degrees = 180

		LookDirection.UP:
			print("look up, mistah")
			vision_cone.rotation_degrees = -90

		LookDirection.RIGHT:
			print("look to the right, mate")
			vision_cone.rotation_degrees = 0

		LookDirection.DOWN:
			print("look down on me, sir")
			vision_cone.rotation_degrees = 90
