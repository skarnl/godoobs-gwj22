extends Control

func _ready():
	interactions.set_politics()
	if politics.area1["control"]<10:
		$CanvasLayer/base_1.disabled = true
	if politics.area2["control"]<10:
		$CanvasLayer/base_2.disabled = true
	if politics.area3["control"]<10:
		$CanvasLayer/main_enemy_base.disabled = true
	$CanvasLayer/home_base/progress.text = "progress : %s"%politics.area0["control"]
	$CanvasLayer/base_1/progress.text = "progress : %s"%politics.area1["control"]
	$CanvasLayer/base_2/progress.text = "progress : %s"%politics.area2["control"]
	$CanvasLayer/main_enemy_base/progress.text = "progress : %s"%politics.area3["control"]
	


func _on_home_base_button_up():
	SceneLoader.goto_scene("res://levels/level1.tscn")


func _on_base_1_button_up():
	SceneLoader.goto_scene("res://levels/level1.tscn")


func _on_base_2_button_up():
	SceneLoader.goto_scene("res://levels/level1.tscn")


func _on_main_enemy_base_button_up():
	SceneLoader.goto_scene("res://levels/level1.tscn")
