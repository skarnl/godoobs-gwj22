extends KinematicBody2D

signal player_detected
signal player_lost

onready var look_rotation = $LookRotation
onready var body_animator = $AnimationPlayer

var player:Node2D
var motion = Vector2()
export var MOVEMENT_SPEED = 100

var colors = ['white', 'orange', 'black']

var _current_color

func _ready():
	randomize()
	_current_color = colors[randi() % colors.size()]
	
	set_physics_process(false)
	body_animator.play("idle_right__%s" % _current_color)
	

func _on_vision_cone_area_entered(area):
	if area.name == "detection_area":
		emit_signal("player_detected")
		
		set_physics_process(true)
		body_animator.play("walk_right__%s" % _current_color)
	
func _physics_process(delta):
	motion = (player.get_global_position() - self.global_position)
	move_and_slide(motion.normalized() * MOVEMENT_SPEED)
	focus_on_player()
	
func _on_vision_cone_area_exited(area):
	if area.name == "detection_area":
		emit_signal("player_lost")
		
		set_physics_process(false)
		body_animator.play("idle_right__%s" % _current_color)


func focus_on_player():
	if not player:
		return
		
	look_at(player.position)

func _on_player_detector_area_entered(area):
	if area.name=="detection_area":
		Game.transition_to(Game.GameState.GAME_OVER)


func set_player_reference(player_reference:Node2D):
	player = player_reference
