extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$level_skip_button.connect("pressed", self, "_on_level_skip_button_pressed")


func _on_level_skip_button_pressed():
	Game.goto_next_level()
