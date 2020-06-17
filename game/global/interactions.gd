extends Node

signal progress_changed
signal dialog_started()

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


# start the quest-dialog from wherever the npc is located
func start_dialog(quest_id: String) -> void:
	print("interactions: start dialog: ", quest_id)
	
	emit_signal("dialog_started", quest_id)
