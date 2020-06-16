extends Control

var ItemNode = preload("res://gui/ItemNode.tscn")

onready var items = $Items

func _ready():
	Inventory.connect("items_changed", self, "_on_Inventory_items_changed")
	

func _on_Inventory_items_changed():
	var inventory_items = Inventory.get_items()
	
	_remove_existing_nodes()
	
	#wait one frame, since we did a queue_free - so the nodes need 1 frame to be removed
	yield(get_tree(),"idle_frame")
	
	for item_index in inventory_items.size():
		if inventory_items[item_index].picked_up:
			_spawn_new_inventory_node(item_index)
	

# for simplicity sake we will just remove all children and readd them
# I'm lazy and don't want to come up with a mechanism to see what node we already added and the order of it etc
func _remove_existing_nodes():
	if items.get_child_count() > 0:
		for node in items.get_children():
			node.queue_free()
		

func _spawn_new_inventory_node(item_index):
	var node = ItemNode.instance()
	node.set_frame(item_index)
	
	if items.get_child_count() > 0:
		node.position.x = 22 * items.get_child_count()
		
	items.add_child(node)
