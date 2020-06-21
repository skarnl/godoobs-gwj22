extends CanvasLayer

#SoundVar#
var music_clip_menu : AudioStream = load("res://assets/Sound/Music/Menu/Menu.ogg")
var music_clip_game : AudioStream = load("res://assets/Sound/Music/Stealth/Stealth.ogg")
###SoundVarEnd###
onready var credits = $credits
onready var credits_close_button = $credits/close_button


func _ready():
	#sound#
	AudioManager.play_music(music_clip_menu)
	###soundEnd###
	print($Panel/start_button)
	
	$Panel/start_button.connect("pressed", self, "_on_start_button_pressed")
	$Panel/credits_button.connect("pressed", self, "_on_credits_button_pressed")
	$Panel/quit_button.connect("pressed", self, "_on_quit_button_pressed")
	credits_close_button.connect("pressed", self, "_on_credits_close_button_pressed")
	
	credits.hide()
	$Panel/start_button.grab_focus()


func _on_start_button_pressed():
	#sound#
	AudioManager.play_music(music_clip_game)
	###soundEnd###
	Game.start_game()
	

func _on_credits_button_pressed():
	credits.show()
	credits_close_button.grab_focus()
	
	
func _on_credits_close_button_pressed():
	credits.hide()
	$Panel/credits_button.grab_focus()
	
	
func _on_quit_button_pressed():
	get_tree().quit()

