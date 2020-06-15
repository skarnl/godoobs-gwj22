extends Node2D

onready var current_root = $current_scene_root

func _ready():
	print(politics.area0["control"])
	interactions.progress=politics.area0["control"]

func _on_player_area_lost():
	politics.area0["control"]=interactions.progress
	
	SceneLoader.goto_scene("res://menu/map.tscn")
