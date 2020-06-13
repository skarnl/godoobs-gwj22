extends StaticBody2D

var dialog_box=preload("res://scenes/GUI/dialogue_box.tscn")

func _on_Area2D_body_entered(body):
	var dbox=dialog_box.instance()
	dbox.name="dia_box"
	add_child(dbox)
	dbox.read("dialogue_info",false)


func _on_Area2D_body_exited(body):
	if has_node("dia_box"):
		get_node("dia_box").destroy()
