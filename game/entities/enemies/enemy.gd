extends KinematicBody2D

signal player_detected

enum LookDirection {
	LEFT,
	UP,
	RIGHT,
	DOWN
}

onready var look_rotation = $LookRotation
onready var body_animator = $AnimationPlayer

var player:Node2D
var is_player_seen:=false
var motion = Vector2()
export var MOVEMENT_SPEED = 100
export var detection_speed=1000 #how fast does the enemy reduce the progress
export var value=10 #how much does killing this enemy cost for the progress
var x:float

var colors = ['white', 'orange', 'black']

var _current_color

func _ready():
	_current_color = colors[randi() % colors.size()]
	
	set_physics_process(false)
	body_animator.play("idle_right__%s" % _current_color)
	
	
	

func _on_vision_cone_area_entered(area):
	if area.name == "detection_area":
		emit_signal("player_detected")
		is_player_seen=true
		x=interactions.progress
		set_physics_process(true)
		body_animator.play("walk_right__%s" % _current_color)
	
func _physics_process(delta):
	motion = (player.get_global_position() - self.global_position)
	x-=delta*detection_speed/motion.length()
	motion /= motion.length()
	motion *= MOVEMENT_SPEED
	move_and_slide(motion)
	focus_on_player()
	interactions.progress=x

func _on_vision_cone_area_exited(area):
	if area.name == "detection_area":
		motion = 0
		is_player_seen=false
		set_physics_process(false)
		body_animator.play("idle_right__%s" % _current_color)


func focus_on_player():
	if not player:
		return
		
	look_at(player.position)

func destroy():
	interactions.progress-=value
	print("enemy dies")
	queue_free()

func _on_player_detector_area_entered(area):
	#TODO trigger game-over state
	
	if area.name=="detection_area":
		Game.transition_to(Game.GameState.GAME_OVER)
#		if is_player_seen:
#			area.get_parent().destroy()
#			is_player_seen=false
#			print("player dies")
#		else:
#			destroy()


func set_player_reference(player_reference:Node2D):
	player = player_reference
