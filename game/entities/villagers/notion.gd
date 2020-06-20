extends Node2D

func _ready():
	$notion_area.connect("body_entered", self, '_on_notion_area_body_entered')
	$notion_area.connect("body_exited", self, '_on_notion_area_body_exited')

func _on_notion_area_body_entered(body):
	print(body)
	print(body.name)
	$AnimationPlayer.play("bounce")	

func _on_notion_area_body_exited(body):
	$AnimationPlayer.stop(true)
	$AnimationPlayer.seek(0)
