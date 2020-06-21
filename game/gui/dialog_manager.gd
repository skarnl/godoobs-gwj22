extends VBoxContainer

signal dialog_finished

onready var question_text := $question/text as RichTextLabel
onready var response1 := $responses/response1 as Button
onready var response2 := $responses/response2 as Button
onready var response3 := $responses/response3 as Button
onready var character_sprite := $"../character_sprite" as AnimatedSprite

var _dialogs: Dictionary
var _current_quest_id: String
var _current_quest_status: String
var _current_dialog: Dictionary
var _current_follower_id: String

func _ready():
	response1.connect('pressed', self, '_on_response1_button_pressed')
	response2.connect('pressed', self, '_on_response2_button_pressed')
	response3.connect('pressed', self, '_on_response3_button_pressed')

func start(quest_id: String, json: Dictionary) -> void:
	_current_quest_id = quest_id
	_dialogs = json.dialogs
	_current_follower_id = json.follower_id
	_current_quest_status = Game.get_quest_state(quest_id)
	if _current_quest_status == Game.QuestState.DONE:
		character_sprite.set_frame(ItemTypes.types[json.follower_id] + 9) # TODO fix this number when we add more characters
	else:
		character_sprite.set_frame(ItemTypes.types[json.follower_id])
	
	_current_dialog = _get_entry_point()
	_render_dialog()	


func _get_entry_point():
	for dialog in _get_current_dialog_tree():
		if dialog.has('entry') and dialog.entry:
			return dialog
	

func _render_dialog() -> void:
	question_text.text = _current_dialog.text
	
	_clear_responses()
	
	if _current_dialog.has('responses'):
		var first_button_focussed = false
		
		for index in _current_dialog.responses.size():
			var response := _current_dialog.responses[index] as Dictionary
			var show_button = true
			
			if response.has('conditional_item'):
				show_button = Inventory.is_item_picked_up(response.conditional_item)
			
			if show_button:
				var button = $responses.get_node("response" + str(index + 1)) as Button
				button.text = response.text
				button.show()
				
				if not first_button_focussed:
					button.grab_focus()
					first_button_focussed = true
	else:
		response1.text = 'Continue'
		response1.show()
		response1.grab_focus()


func find_dialog_by_label(label: String):
	for dialog in _get_current_dialog_tree():
		if dialog.label == label:
			return dialog


func _clear_responses() -> void:
	response1.text = ''
	response1.hide()
	
	response2.text = ''
	response2.hide()
	
	response3.text = ''
	response3.hide()


func _get_current_dialog_tree() -> Array:
	return _dialogs[_current_quest_status]


func _on_response1_button_pressed():
	print("_on_response1_button_pressed")
	if _current_dialog.has('responses'):
		_handle_response(_current_dialog.responses[0])
	else:
		if _current_dialog.has('next_state'):
			Game.set_quest_state(_current_quest_id, _current_dialog.next_state, _current_follower_id)
		
		_close_dialog()


func _on_response2_button_pressed():
	print("_on_response2_button_pressed")
	_handle_response(_current_dialog.responses[1])
	
	
func _on_response3_button_pressed():
	print("_on_response3_button_pressed")
	_handle_response(_current_dialog.responses[2])


func _handle_response(response: Dictionary) -> void:
	if response.has('conditional_item'):
		Inventory.deliver(response.conditional_item)
	
	if response.has('next_state'):
		Game.set_quest_state(_current_quest_id, response.next_state, _current_follower_id)
		
		_close_dialog()
	elif response.has('next_label'):
		_current_dialog = find_dialog_by_label(response.next_label)
		_render_dialog()
	else:
		_close_dialog()


func _close_dialog() -> void:
	emit_signal("dialog_finished")
