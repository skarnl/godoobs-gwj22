extends Sprite


func _ready():
	$AnimationPlayer.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")
	$AnimationPlayer.play("splash_intro")


func _on_AnimationPlayer_animation_finished(animation_name):
	SceneLoader.goto_scene("res://scenes/main.tscn")
