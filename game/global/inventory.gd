extends Node

signal items_changed

var items = {}

const ItemTypes = preload("res://global/ItemTypes.gd")

func _ready():	
	# initialize the items-dict with all the available types
	for index in ItemTypes.types.values():
		items[index] = { 
			"id": index,
			"name": str(ItemTypes.types.keys()[index]),
			"picked_up": false
		}


func get_items() -> Dictionary:
	return items


func get_items_picked_up() -> Array:
	var picked_up_items = []
	for item in items:
		if item.picked_up:
			picked_up_items.append(item)
	
	return picked_up_items


func pickup(item_index) -> void:
	assert(item_index in items)

	print("Item [%s] picked up" % items[item_index].name)
	
	mark_item_picked_up(item_index)
	
	emit_signal('items_changed')
	
	
func mark_item_picked_up(item_index) -> void:
	items[item_index].picked_up = true
	
