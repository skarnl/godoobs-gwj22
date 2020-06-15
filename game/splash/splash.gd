extends Control

onready var animation_player = $CanvasLayer/Sprite/AnimationPlayer

# an option to disable the splash - for debugging purposes
export var skip_splash = false


func _ready():
	if skip_splash:
		print('skip the splash - for debugging purposes')
		_on_AnimationPlayer_animation_finished("skip it");

	animation_player.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")
	animation_player.play("splash_intro")


func _on_AnimationPlayer_animation_finished(animation_name):
	SceneLoader.goto_scene("res://levels/level1.tscn")
