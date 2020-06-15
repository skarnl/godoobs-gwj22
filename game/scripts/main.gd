extends Node2D

enum State {
	Splash,
	Game,
	Death
}
var map:PackedScene
onready var current_root = $current_scene_root

func _ready():
	map = load("res://scenes/GUI/map.tscn")
	print(politics.area0["control"])
	interactions.progress=politics.area0["control"]

func _on_player_area_lost():
	politics.area0["control"]=interactions.progress
	get_tree().change_scene_to(map)
