extends Node2D

enum State {
	Splash,
	Game,
	Death
}

onready var current_root = $current_scene_root

func _on_player_cover_area_entered(area):
	if area.name=="hide_area":
		area.get_parent().get_node("detection_area").collision_layer=0
		area.get_parent().get_node("detection_area").collision_mask=13


func _on_player_cover_area_exited(area):
	if area.name=="hide_area":
		area.get_parent().get_node("detection_area").collision_layer=1
		area.get_parent().get_node("detection_area").collision_mask=15
