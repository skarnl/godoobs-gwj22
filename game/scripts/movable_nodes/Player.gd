extends KinematicBody2D

signal area_liberated
signal area_lost
var motion:Vector2
export var speed = 500

func _ready():
	interactions.connect("progress_changed",self,"change_progress_bar")
	interactions.progress=50

func _physics_process(delta):
	var inp_x = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	var inp_y = Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up")
	if inp_x != 0 or inp_y != 0:
		motion = Vector2(inp_x,inp_y).normalized()*speed
	else:
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
