extends Node2D
class_name Item

enum ItemType {
	BREAD,	
	VODKA,
	CHEESE,
	FIRECRACKER,
	CLOCK,
	STICK
}

export(ItemType) var item_type

signal pickup

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer
onready var hit_detection = $Area2D

func _ready():
	assert(item_type != null)

	#TODO register with some global thing (Inventory?) so it can connect

	sprite.set_frame(item_type)

	print("ITEM READY")
	print('hit_detection', hit_detection)
	

	hit_detection.connect("body_entered", self, "_on_Area2D_body_entered")


func _on_Area2D_body_entered(_body):
	print("hit me")

	#TODO add check to see if Inventory is full
	hit_detection.set_monitoring(false)
	
	animation_player.play("pickup")
	
	yield(animation_player, "animation_finished")
	
	emit_signal("pickup", item_type)

	queue_free()
