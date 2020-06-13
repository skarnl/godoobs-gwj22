extends Node2D

enum State {
	Splash,
	Game,
	Death
}

onready var current_root = $current_scene_root

func _on_player_cover_area_entered(area):
	if area.name=="hide_area":
		area.get_parent().get_node("detection_area").monitorable=false


func _on_player_cover_area_exited(area):
	if area.name=="hide_area":
		area.get_parent().get_node("detection_area").monitorable=true
