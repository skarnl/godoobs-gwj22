extends Control

func _ready():
	if politics.area1["control"]<10:
		$CanvasLayer/base_1.disabled = true
	elif politics.area2["control"]<10:
		$CanvasLayer/base_2.disabled = true
	elif politics.area3["control"]<10:
		$CanvasLayer/main_enemy_base.disabled = true



func _on_home_base_button_up():
	SceneLoader.goto_scene("res://levels/level1.tscn")


func _on_base_1_button_up():
	SceneLoader.goto_scene("res://levels/level1.tscn")


func _on_base_2_button_up():
	SceneLoader.goto_scene("res://levels/level1.tscn")


func _on_main_enemy_base_button_up():
	SceneLoader.goto_scene("res://levels/level1.tscn")
