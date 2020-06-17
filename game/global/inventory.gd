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
			"picked_up": false,
			"delivered": false
		}


func get_items() -> Dictionary:
	return items


func get_items_picked_up() -> Array:
	var picked_up_items = []
	for item in items.values():
		if item.picked_up:
			picked_up_items.append(item)
	
	return picked_up_items


func pickup(item_index) -> void:
	assert(item_index in items)

	print("Item [%s] picked up" % items[item_index].name)
	
	items[item_index].picked_up = true
	
	emit_signal('items_changed')
	
	
func is_item_picked_up(name: String) -> bool:
	for item in items.values():
		if item.name == name:
			return item.picked_up

	print('ERROR: Item %s cant be found in the Inventory' % name)
	return false


func deliver(item_name: String) -> void:
	var item_index = _get_item_index_by_name(item_name)
	
	if item_index != -1:
		print("Item [%s] delivered" % items[item_index].name)
		items[item_index].delivered = true
			
	emit_signal('items_changed')


func _get_item_index_by_name(name: String) -> int:
	for item_index in items:
		if items[item_index].name == name:
			return item_index
			
	return -1
