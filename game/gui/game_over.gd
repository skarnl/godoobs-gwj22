extends Control

func _ready():
	hide()
	
	Game.connect("game_over", self, "_on_Game_game_over")


func _on_Game_game_over():
	show()
	
	$Timer.start()
	

	yield($Timer, "timeout")
	
	Game.transition_to(Game.GameState.MENU)
