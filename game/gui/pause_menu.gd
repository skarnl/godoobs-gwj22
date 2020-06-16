extends Control

func _ready():
	var pos1=$CanvasLayer/Button.get_global_position()
	var pos2=$CanvasLayer/Button2.get_global_position()
	$CanvasLayer/Button.set_as_toplevel(true)
	$CanvasLayer/Button.set_global_position(pos1)
	$CanvasLayer/Button2.set_as_toplevel(true)
	$CanvasLayer/Button2.set_global_position(pos2)

func _on_Button_button_up():
	get_tree().paused=false
	$CanvasLayer/Button.visible = false
	$CanvasLayer/Button2.visible = false
	$CanvasLayer/ColorRect.visible = false


func _on_Button2_button_up():
	get_tree().paused = false
	$CanvasLayer/Button.visible = false
	$CanvasLayer/Button2.visible = false
	$CanvasLayer/ColorRect.visible = false
	get_parent().get_parent()._on_player_area_lost()

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			$CanvasLayer/Button.visible = true
			$CanvasLayer/Button2.visible = true
			$CanvasLayer/ColorRect.visible = true
			get_tree().paused = true
