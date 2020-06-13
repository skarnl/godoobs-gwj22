extends KinematicBody2D

signal player_detected

enum LookDirection {
	LEFT,
	UP,
	RIGHT,
	DOWN
}

onready var vision_cone = $LookRotation
onready var player = $"../player"

var MOVEMENT_SPEED = 10

var is_player_detected = false

export(LookDirection) var look_direction = LookDirection.RIGHT

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


func _on_VisionCone_body_entered(_body):
	print("player detected!")
	is_player_detected = true

	# check if we have need to dispatch this outside the enemy
	# should 'the world' know an enemy has detected the player?
	emit_signal("player_detected")

func _physics_process(delta):
	if not is_player_detected:
		return
	
	var vector = player.position

	move_and_slide(vector * MOVEMENT_SPEED * delta)
