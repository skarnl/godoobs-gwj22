extends KinematicBody2D

signal player_detected

enum LookDirection {
	LEFT,
	UP,
	RIGHT,
	DOWN
}

onready var look_rotation = $LookRotation
onready var sweep_animator = $LookRotation/AnimationPlayer
onready var player = get_parent().get_parent().get_node("player")
var motion = Vector2()

export var MOVEMENT_SPEED = 50

export(LookDirection) var look_direction = LookDirection.RIGHT

func _ready():
	set_physics_process(false)

	match look_direction:
		LookDirection.LEFT:
			look_rotation.rotation_degrees = 180

		LookDirection.UP:
			look_rotation.rotation_degrees = -90

		LookDirection.RIGHT:
			look_rotation.rotation_degrees = 0

		LookDirection.DOWN:
			look_rotation.rotation_degrees = 90

	start_looking()
	

func _on_vision_cone_area_entered(area):
	if area.name == "detection_area":
		emit_signal("player_detected")
		set_physics_process(true)
	
func _physics_process(delta):
	motion = (player.get_global_position() - self.global_position)
	motion /= motion.length()
	motion *= MOVEMENT_SPEED
	move_and_slide(motion)
	
	stop_looking()
	focus_on_player()

func _on_vision_cone_area_exited(area):
	if area.name == "detection_area":
		print("player escaped")
		motion = 0
		set_physics_process(false)
		start_looking()


func stop_looking():
	sweep_animator.stop()


func start_looking():
	sweep_animator.play()


func focus_on_player():
	look_rotation.get_node("PivotPoint").look_at(player.position)
