extends Button


func _ready():
	connect("button_down", self, "_on_button_down")
	connect("button_up", self, "_on_button_up")


func _on_button_down():
	$Sprite.set_frame(1)

func _on_button_up():
	$Sprite.set_frame(0)
