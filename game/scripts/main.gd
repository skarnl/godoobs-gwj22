extends Node2D

enum State {
	Splash,
	Game,
	Death
}

onready var SplashScene = preload("res://scenes/splash.tscn")
onready var GameScene = preload("res://scenes/game.tscn")
onready var current_root = $CurrentSceneRoot

var state = State.Splash
var splash
var game

func _ready():
	load_splash()


func load_splash():
	splash = SplashScene.instance()
	current_root.add_child(splash)
	get_tree().set_current_scene(splash)
	splash.get_node("Timer").connect("timeout", self, "_on_SplashScreen_timeout")


func _on_SplashScreen_timeout():
	clear_splash()
	load_game()
	

func clear_splash():
	if splash:
		splash.queue_free()
		splash = null

func load_game():
	game = GameScene.instance()
	current_root.add_child(game)
	get_tree().set_current_scene(game)
