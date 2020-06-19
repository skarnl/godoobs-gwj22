extends Node2D

func _ready():
	var pos1=$CanvasLayer/Button.get_global_position()
	var pos2=$CanvasLayer/Button2.get_global_position()
	$CanvasLayer/Button.set_as_toplevel(true)
	$CanvasLayer/Button.set_global_position(pos1)
	$CanvasLayer/Button2.set_as_toplevel(true)
	$CanvasLayer/Button2.set_global_position(pos2)
	
	Game.connect("game_paused", self, "_on_Game_game_paused")
	Game.connect("game_resumed", self, "_on_Game_game_resumed")
	
	_toggle(false)


func _on_Button_button_up():
	Game.transition_to(Game.GameState.GAME)


func _on_Button2_button_up():
	Game.transition_to(Game.GameState.MENU)
	

func _on_Game_game_paused():
	_toggle(true)
	

func _on_Game_game_resumed():
	_toggle(false)


func _toggle(show: bool):
	$CanvasLayer/Label.visible = show
	$CanvasLayer/Button.visible = show
	$CanvasLayer/Button2.visible = show
	$CanvasLayer/ColorRect.visible = show
