extends Control

signal area_liberated

onready var progress_bar = $canvas_layer/progress_bar

func _ready():
	interactions.connect("progress_changed",self,"change_progress_bar")
	interactions.progress = 50

func change_progress_bar(new_value:float):
	if new_value == 100:
		print("area liberated!!")
		emit_signal("area_liberated")
	elif new_value == 0:
		print("area lost!!")
		emit_signal("area_lost")
	
	progress_bar.value = new_value
