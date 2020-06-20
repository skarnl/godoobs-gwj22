extends Control

func _ready():
	hide()
	$Panel/Button.connect("pressed", self, "_on_Button_pressed")
	Game.connect("level_finished", self, "_on_Game_level_finished")

func _on_Game_level_finished():
	show()
	$Panel/Button.grab_focus()


func _on_Button_pressed():
	Game.goto_next_level()
