extends Control

var dest1 = preload("res://scenes/main.tscn")
var dest2 = preload("res://scenes/main.tscn")
var dest3 = preload("res://scenes/main.tscn")
var dest4 = preload("res://scenes/main.tscn")

func _ready():
	
	if politics.area1["control"]<10:
		$CanvasLayer/base_1.disabled = true
	elif politics.area2["control"]<10:
		$CanvasLayer/base_2.disabled = true
	elif politics.area3["control"]<10:
		$CanvasLayer/main_enemy_base.disabled = true



func _on_home_base_button_up():
	get_tree().change_scene_to(dest1)


func _on_base_1_button_up():
	get_tree().change_scene_to(dest2)


func _on_base_2_button_up():
	get_tree().change_scene_to(dest3)


func _on_main_enemy_base_button_up():
	get_tree().change_scene_to(dest4)
