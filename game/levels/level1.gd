extends Node2D


onready var current_root = $current_scene_root

func _ready():
	interactions.progress = politics.area0["control"]

func _on_player_area_lost():
	politics.area0["control"] = interactions.progress
	interactions.set_politics(politics.area0)
	SceneLoader.goto_scene("res://menu/map.tscn")

