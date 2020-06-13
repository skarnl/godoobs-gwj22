extends Control

signal stop

onready var lab=$CanvasLayer/ColorRect2/Label
var reading=false
var i:=0
var dialogue_read:String
var dict:Array
var fin=false

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") and i<len(dict)+1:
		if !reading:
			if !fin:
				read_dialog()
			else:
				read_final_dialog()
		else:
			lab.visible_characters=-1
			$CanvasLayer/ColorRect2/Tween.stop(lab)
			reading=false
			i+=1

func read(dialog,final:bool):
	$CanvasLayer/player_choice.visible=false
	i=0
	if !final:
		dialogue_read=dialog
		dict=interactions.dialogue_dict["%s"%dialogue_read]
		read_dialog()
	else:
		fin=true
		dialogue_read=dialog
		dict=interactions.dialogue_dict["%s"%dialogue_read]
		read_final_dialog()

func read_dialog():
	if i==len(dict):
		show_choice()
		return
	reading=true
	lab.text=dict[i]
	lab.visible_characters=0
	$CanvasLayer/ColorRect2/Tween.interpolate_property(lab,"visible_characters",0,len(dict[i]),len(dict[i])/20,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$CanvasLayer/ColorRect2/Tween.start()
	yield($CanvasLayer/ColorRect2/Tween,"tween_completed")
	i+=1
	reading=false

func read_final_dialog():
	if i==len(dict):
		destroy()
		return
	reading=true
	lab.text=dict[i]
	lab.visible_characters=0
	$CanvasLayer/ColorRect2/Tween.interpolate_property(lab,"visible_characters",0,len(dict[i]),len(dict[i])/20,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$CanvasLayer/ColorRect2/Tween.start()
	yield($CanvasLayer/ColorRect2/Tween,"tween_completed")
	i+=1
	reading=false

func show_choice():
	$CanvasLayer/player_choice.visible=true

func destroy():
	queue_free()


func _on_left_option_button_up():
	read("%s_yes"%dialogue_read,true)


func _on_right_option_button_up():
	read("%s_no"%dialogue_read,true)
