extends Node

signal progress_changed

var progress:float setget set_progress

func set_progress(value):
	if value<=0:
		value=0
	elif value>=100:
		value=100
	progress=value
	emit_signal("progress_changed",value)
