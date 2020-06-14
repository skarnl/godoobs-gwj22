extends KinematicBody2D

signal area_liberated
signal area_lost
var motion:Vector2
export var speed = 500

onready var animation_player = $AnimationPlayer
onready var animation_tree:AnimationTree = $AnimationTree
onready var animation_state:AnimationNodeStateMachine = animation_tree.get("parameters/playback")

func _ready():
	interactions.connect("progress_changed",self,"change_progress_bar")
	interactions.progress=50

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
		animation_state.travel("Walking")
		
		motion = input_vector * speed
	else:
		animation_state.travel("Idle")

		motion = Vector2.ZERO

	move_and_slide(motion)

func destroy():
	queue_free()

func change_progress_bar(new_value:float):
	if new_value==100:
		print("area liberated!!")
		emit_signal("area_liberated")
	elif new_value==0:
		print("area lost!!")
		emit_signal("area_lost")
	$player_UI/canvas_layer/progress_bar.value=new_value


func register_with_all_enemies():
	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.set_player_reference(self)
