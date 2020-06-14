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
var player:Node2D
var is_player_seen:=false
var motion = Vector2()
export var MOVEMENT_SPEED = 50
export var detection_speed=1000 #how fast does the enemy reduce the progress
export var value=10 #how much does killing this enemy cost for the progress
var x:float
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
		is_player_seen=true
		x=interactions.progress
		set_physics_process(true)
	
func _physics_process(delta):
	motion = (player.get_global_position() - self.global_position)
	x-=delta*detection_speed/motion.length()
	motion /= motion.length()
	motion *= MOVEMENT_SPEED
	move_and_slide(motion)
	stop_looking()
	focus_on_player()
	interactions.progress=x

func _on_vision_cone_area_exited(area):
	if area.name == "detection_area":
		motion = 0
		is_player_seen=false
		set_physics_process(false)
		start_looking()


func stop_looking():
	sweep_animator.stop()


func start_looking():
	sweep_animator.play()


func focus_on_player():
	if not player:
		return
		
	look_rotation.get_node("PivotPoint").look_at(player.position)

func destroy():
	interactions.progress-=value
	print("enemy dies")
	queue_free()

func _on_player_detector_area_entered(area):
	if area.name=="detection_area":
		if is_player_seen:
			area.get_parent().destroy()
			is_player_seen=false
			print("player dies")
		else:
			destroy()


func set_player_reference(player_reference:Node2D):
	player = player_reference
