extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	
	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.connect("player_detected", self, "_on_Enemy_player_detected")
		enemy.connect("player_lost", self, "_on_Enemy_player_lost")


func _on_Enemy_player_detected():
	show()
	
	$AnimationPlayer.play("detected")
	
	get_tree().paused = true
	
	yield(get_tree().create_timer(0.8), "timeout")
	
	get_tree().paused = false

func _on_Enemy_player_lost():
	$AnimationPlayer.stop()
	
	hide()
