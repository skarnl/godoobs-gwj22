# this script will hold the overall game state

extends Node

var QuestState = {
	"NOT_ACTIVE": "not_active",
	"ACTIVE": "active",
	"DONE": "done"
}

var quest_states = {}

func get_quest_state(quest_id: String) -> String:
	if quest_states.has(quest_id):
		return quest_states[quest_id]
		
	return QuestState.NOT_ACTIVE

func set_quest_state(quest_id: String, state: String) -> void:
	assert(state in QuestState.values())
	quest_states[quest_id] = state

# TODO we need to keep track of the global application state
# so we can act depending on what state we are in (State Machine pattern)

#enum State {
#	SPLASH,
#	PAUSED,
#	MAIN_MENU,
#	MAP,
#	GAME
#}
#
#var _current_state: State = State.GAME setget _set_current_state

# change the state to the next
#func transition_to(new_state: State) -> void:
	
