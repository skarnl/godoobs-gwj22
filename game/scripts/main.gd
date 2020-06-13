extends Node2D

enum State {
	Splash,
	Game,
	Death
}

onready var current_root = $current_scene_root
var dialog_box=preload("res://scenes/GUI/dialogue_box.tscn")

func _ready():
	pass



func _on_Area2D_body_entered(body):
	if body.name=="player":
		var dbox=dialog_box.instance()
		dbox.name="dia_box"
		add_child(dbox)
		dbox.read("dialogue_info",false)


func _on_Area2D_body_exited(body):
	if body.name=="player":
		if has_node("dia_box"):
			get_node("dia_box").destroy()
