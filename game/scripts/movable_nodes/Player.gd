extends KinematicBody2D

var motion:Vector2
export var speed = 500

func _physics_process(delta):
	var inp_x = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	var inp_y = Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up")
	if inp_x != 0 or inp_y != 0:
		motion = Vector2(inp_x,inp_y).normalized()*speed
	else:
		motion = Vector2.ZERO
	
	move_and_slide(motion)
