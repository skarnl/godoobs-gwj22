extends Area2D


func _ready():
	connect("area_entered",self,"_on_player_cover_area_entered")
	connect("area_exited",self,"_on_player_cover_area_exited")

func _on_player_cover_area_entered(area):
	if area.name == "hide_area":
		area.get_parent().get_node("detection_area").collision_layer=0
		area.get_parent().get_node("detection_area").collision_mask=13


func _on_player_cover_area_exited(area):
	if area.name == "hide_area":
		area.get_parent().get_node("detection_area").collision_layer=1
		area.get_parent().get_node("detection_area").collision_mask=15
