extends StaticBody2D

#var dialog_box=preload("res://gui/dialogue_box.tscn")
#
#var dialogue_dict={
#	"dialogue_info":["hi, this is a villager. When asking me a question, please make sure you refer to the autoload \"interactions\" scene to refer to the dialogue I say when asking a question"],
#	"dialogue_info_yes":["this is a positive response. I am for the revoution"],
#	"dialogue_info_no":["this is a negative response. I am against the revolution"]
#}

export var quest_id:String

#var dialogued=false
#export var villager_value=20 #how much percentage does this villager contribute to the revolution
#var ally:bool

func _on_Area2D_body_entered(body):
	interactions.start_dialog(quest_id)
	

#	if !dialogued:
#		var dbox=dialog_box.instance()
#		dbox.name="dia_box"
#		add_child(dbox)
#		dbox.read("dialogue_info",false)
	
#	if has_node("dia_box"):
#		get_node("dia_box").destroy()
#
#func convert_positive():
#	$Sprite.self_modulate=Color(0,1,0,1)
#	ally=true
#	dialogued=true
#	interactions.progress+=villager_value
#
#func convert_negative():
#	$Sprite.self_modulate=Color(1,0,1,1)
#	ally=false
#	dialogued=true
#	interactions.progress-=villager_value/2
#func change_status(status:bool):
#	if status:
#		convert_positive()
#	else:
#		convert_negative()
