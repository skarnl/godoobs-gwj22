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

func set_politics(area:Dictionary={}):
	if area.empty():
		politics.area1["control"] = politics.area0["control"]/4
		politics.area2["control"] = politics.area0["control"]/4 
		politics.area3["control"] = politics.area1["control"]/4 + politics.area2["control"]/4
		return
	var x=progress-area["control"]
	politics.area1["control"] = politics.area0["control"]/4
	politics.area2["control"] = politics.area0["control"]/4 
	politics.area3["control"] = politics.area1["control"]/4 + politics.area2["control"]/4
	area["control"] += x
