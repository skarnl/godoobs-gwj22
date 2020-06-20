# this script will hold the overall game state

extends Node

signal game_paused
signal game_resumed
signal level_finished


enum GameState {
	SPLASH,
	MENU,
	GAME,
	GAME_DIALOG_OPENED,
	PAUSED,
	GAME_OVER
}

# TODO we need to keep track of the global application state
# so we can act depending on what state we are in (State Machine pattern)

var _current_state: int = GameState.GAME setget _set_current_state
var _previous_state: int

var QuestState = {
	"NOT_ACTIVE": "not_active",
	"ACTIVE": "active",
	"DONE": "done"
}

var quest_states = {}
var _current_level_index = 1

var is_current_level_finished = false

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS


func get_quest_state(quest_id: String) -> String:
	if quest_states.has(quest_id):
		return quest_states[quest_id]
		
	return QuestState.NOT_ACTIVE

func set_quest_state(quest_id: String, state: String, follower_id: String) -> void:
	assert(state in QuestState.values())
	quest_states[quest_id] = state
	
	if state == QuestState.DONE:
		Progress.add_follower(follower_id)
		
		if Progress.get_followers().size() > 0 and Progress.get_followers().size() % 2 == 0:
			is_current_level_finished = true

# change the state to the next
func transition_to(new_state: int) -> void:
	match _current_state:
		GameState.SPLASH:
			if new_state == GameState.MENU:
				_current_state = GameState.MENU
				SceneLoader.goto_scene('res://menu/main_menu.tscn')
		
		GameState.MENU:
			if new_state == GameState.GAME:
				_current_state = GameState.GAME
				SceneLoader.goto_scene('res://levels/level_01.tscn')
				
		GameState.GAME:
			match new_state:
				GameState.PAUSED:
					_current_state = GameState.PAUSED
					emit_signal("game_paused")
					get_tree().paused = true
				
				GameState.GAME_DIALOG_OPENED:
					_current_state = GameState.GAME_DIALOG_OPENED
					get_tree().paused = true
			
				GameState.GAME_OVER:
					_current_state = GameState.GAME_OVER
#					get_tree().paused = true ???
					SceneLoader.goto_scene('res://ui/game_over.tscn')
		
		GameState.GAME_DIALOG_OPENED:
				match new_state:
					GameState.GAME:
						_current_state = GameState.GAME
						get_tree().paused = false
						
						if is_current_level_finished:
							emit_signal("level_finished")
							get_tree().paused = true
						
					GameState.PAUSED:
						_current_state = GameState.PAUSED
						emit_signal("game_paused")
						get_tree().paused = true
		
		GameState.GAME_OVER:
			if new_state == GameState.MENU:
				_current_state = GameState.MENU
				SceneLoader.goto_scene('res://menu/main_menu.tscn')
				
		GameState.PAUSED:
			match new_state:
				GameState.MENU:
					_current_state = GameState.MENU
					get_tree().paused = false
					emit_signal("game_resumed")
					SceneLoader.goto_scene('res://menu/main_menu.tscn')
				
				GameState.GAME:
					_current_state = GameState.GAME
					get_tree().paused = false
					emit_signal("game_resumed")

				GameState.GAME_DIALOG_OPENED:
					_current_state = GameState.GAME_DIALOG_OPENED
					emit_signal("game_resumed")


func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			match _current_state:
				GameState.GAME:
					transition_to(GameState.PAUSED)
			
				GameState.GAME_DIALOG_OPENED:
					transition_to(GameState.PAUSED)
			
				GameState.PAUSED:
					if _previous_state == GameState.GAME_DIALOG_OPENED:
						transition_to(GameState.GAME_DIALOG_OPENED)
					else:
						transition_to(GameState.GAME)


func goto_next_level():
	# TODO play some transition animation first
	# TODO show some kind of message you have gathered enough followers and will continue your quest
	
	is_current_level_finished = false
	get_tree().paused = false
	
	match _current_level_index:
		1: 
			_current_level_index = 2
			SceneLoader.goto_scene('res://levels/level_02.tscn')

		2: 
			_current_level_index = 3
			SceneLoader.goto_scene('res://levels/level_03.tscn')
			
		# THIS NEEDS TO BE VICTORY - BUT OK
		3: 
			_current_level_index = 1
			SceneLoader.goto_scene('res://levels/level_01.tscn')


func get_current_level() -> int:
	return _current_level_index


func _set_current_state(new_state:int) -> void:
	_previous_state = _current_state
	_current_state = new_state

