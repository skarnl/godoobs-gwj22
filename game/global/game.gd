# this script will hold the overall game state

extends Node

signal game_paused
signal game_resumed


enum GameState {
	SPLASH,
	MENU,
	GAME,
	PAUSED,
	GAME_OVER	
}

# TODO we need to keep track of the global application state
# so we can act depending on what state we are in (State Machine pattern)

var _current_state: int = GameState.GAME

var QuestState = {
	"NOT_ACTIVE": "not_active",
	"ACTIVE": "active",
	"DONE": "done"
}

var quest_states = {}
var _current_level_index = 1

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS


func get_quest_state(quest_id: String) -> String:
	if quest_states.has(quest_id):
		return quest_states[quest_id]
		
	return QuestState.NOT_ACTIVE

func set_quest_state(quest_id: String, state: String) -> void:
	assert(state in QuestState.values())
	quest_states[quest_id] = state

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
			if new_state == GameState.PAUSED:
				_current_state = GameState.PAUSED
				_handle_paused(true)
			
			if new_state == GameState.GAME_OVER:
				_current_state = GameState.GAME_OVER
				SceneLoader.goto_scene('res://ui/game_over.tscn')
		
		GameState.GAME_OVER:
			if new_state == GameState.MENU:
				_current_state = GameState.MENU
				SceneLoader.goto_scene('res://menu/main_menu.tscn')
				
		GameState.PAUSED:
			if new_state == GameState.MENU:
				get_tree().paused = false
				_current_state = GameState.MENU
				SceneLoader.goto_scene('res://menu/main_menu.tscn')
				
			if new_state == GameState.GAME:
				_current_state = GameState.GAME
				_handle_paused(false)


func _handle_paused(paused: bool):
	if paused:
		emit_signal("game_paused")
		get_tree().paused = true
	else:
		emit_signal("game_resumed")
		get_tree().paused = false


func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			if _current_state == GameState.GAME:
				transition_to(GameState.PAUSED)
			elif _current_state == GameState.PAUSED:
				transition_to(GameState.GAME)


func goto_next_level():
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
