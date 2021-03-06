extends Node2D

onready var animation_player = $AnimationPlayer
onready var dialog_manager = $Panel/dialog

var is_shown := false

func _ready():
	hide()
	
	interactions.connect("dialog_started", self, "_on_dialog_started")
	dialog_manager.connect("dialog_finished", self, "_on_dialog_finished")
	

func _on_dialog_started(quest_id: String) -> void:
	print("Show dialog for quest id: ", quest_id)
	
	Game.transition_to(Game.GameState.GAME_DIALOG_OPENED)
	
	var json_data = _load_file(quest_id)
	
	assert(json_data)
	dialog_manager.start(quest_id, json_data)
	
	show()
	animation_player.play("slide_in")
	is_shown = true


func _on_dialog_finished() -> void:
	_hide()
	

func _hide() -> void:
	animation_player.play("slide_out")
	yield(animation_player, 'animation_finished')
	Game.transition_to(Game.GameState.GAME)
	is_shown = false
	hide()

	
func _load_file(quest_id):
	var file_path = 'res://data/%s.json' % quest_id
	
	print('Load from: %s' % file_path)
	
	var file = File.new()
	
	if file.file_exists(file_path):
		file.open(file_path, file.READ)
		
		var json_data = parse_json(file.get_as_text())
		
		file.close()
		
		return json_data
	else:
		print("ERROR: File %s can't be loaded")
