extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	
	Game.connect("victory", self, "_on_Game_victory")


func _on_Game_victory():
	show()
	
	$AnimationPlayer.play("show")
	
	yield($AnimationPlayer, "animation_finished")
	
	$Timer.start()

	yield($Timer, "timeout")
	
	Game.transition_to(Game.GameState.MENU)
