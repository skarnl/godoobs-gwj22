extends Node2D
class_name Item

export(ItemTypes.types) var item_type

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer
onready var hit_detection = $Area2D

func _ready():
	assert(item_type != null)

	sprite.set_frame(item_type)

	hit_detection.connect("body_entered", self, "_on_Area2D_body_entered")


func _on_Area2D_body_entered(_body):
	hit_detection.disconnect("body_entered", self, "_on_Area2D_body_entered")
	
	#TODO add check to see if Inventory is full
	hit_detection.set_monitoring(false)
	
	animation_player.play("pickup")
	
	yield(animation_player, "animation_finished")
	
	Inventory.pickup(item_type)

	queue_free()
