extends Sprite


onready var generator = RandomNumberGenerator.new()
onready var screen_size = get_viewport_rect().size

func _ready():
	generator.randomize()

func _on_Timer_timeout():
	position.x += generator.randi_range(-10, 10);
	position.y += generator.randi_range(-10, 10);
	
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
