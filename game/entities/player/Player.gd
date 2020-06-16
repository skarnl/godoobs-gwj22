extends KinematicBody2D

signal area_lost
var motion:Vector2
export var speed = 500

onready var animation_player = $AnimationPlayer
onready var animation_tree:AnimationTree = $AnimationTree
onready var animation_state:AnimationNodeStateMachine = animation_tree.get("parameters/playback")

onready var tail = $TailAnimation
var tail_direction = Vector2.LEFT

func _ready():
	#register by all enemies
	register_with_all_enemies()


func _physics_process(delta):
	var input_vector = Vector2.ZERO

	input_vector.x = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Walking/blend_position", input_vector)
		tail_direction = input_vector

		animation_state.travel("Walking")
		
		motion = input_vector * speed
	else:
		animation_state.travel("Idle")

		motion = Vector2.ZERO

	move_and_slide(motion)
	set_tail_position()

func destroy():
	# TODO this needs to be fixed with the proper callback
	# $player_UI/canvas_layer/popup_message.visible = true
	# $player_UI/canvas_layer/popup_message.text = "Area Lost"
	$TailAnimation.visible = false
	$"Sprite (Body)".visible = false
	$detection_area.monitoring = false
	yield(get_tree().create_timer(1),"timeout")
	# $player_UI/canvas_layer/popup_message.visible = false
	emit_signal("area_lost")
	queue_free()


func register_with_all_enemies():
	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.set_player_reference(self)


func set_tail_position():
	var position = Vector2.ZERO
	var rotation = 0

	
	
	#left down
	if tail_direction.x < 0 and tail_direction.y > 0:
		position = Vector2(14, -14)
		rotation = -135

	#left up
	elif tail_direction.x < 0 and tail_direction.y < 0:
		position = Vector2(14, 14)
		rotation = -45

	#right down
	elif tail_direction.x > 0 and tail_direction.y > 0:
		position = Vector2(-14, -14)
		rotation = 135

	#right up
	elif tail_direction.x > 0 and tail_direction.y < 0:
		position = Vector2(-14, 14)
		rotation = 45

	#pure left
	elif tail_direction.x < 0:
		position = Vector2(23, 0)
		rotation = -90
	
	#pure right
	elif tail_direction.x > 0:
		position = Vector2(-23, 0)
		rotation = 90
	
	#pure bottom
	elif tail_direction.y < 0:
		position = Vector2(0, 23)
		rotation = 0

	#pure top
	elif  tail_direction.y > 0:
		position = Vector2(0, -23)
		rotation = -180

	tail.rotation_degrees = rotation
	tail.position = position
