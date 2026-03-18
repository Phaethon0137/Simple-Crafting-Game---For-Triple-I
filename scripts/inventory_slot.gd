class_name InventorySlot
extends Control

@export var item: Item

@onready var icon: TextureRect = $Icon
@onready var count_lb: Label = $CountLb
@onready var title: Label = $Title

func _process(_delta: float) -> void:
	count_lb.visible = (item != null)
	title.visible = (item != null)
	if item:
		icon.texture = item.item_icon
		icon.texture_filter = item.icon_filter
		count_lb.text = str(item.quantity)
		title.text = item.item_name
		if item.quantity <= 0:
			item = null
	else:
		icon.texture = null
	if (title.text.length() + title.text.count(' ')) >= 12:
		title.label_settings.font_size = 8

func _input(event: InputEvent) -> void:
	var root = get_tree().get_first_node_in_group(&'Inv')#get_owner()
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
			if get_global_rect().abs().has_point(event.global_position):
				#print('Input!!')
				if root is Inventory:
					if item != null:
						if root.cursor_item == null:
							if item.quantity >= 1:
								root.cursor_item = Item.create_copy(item, 1)
								item.quantity -= 1
						else:
							if not event.shift_pressed:
								root.cursor_item.quantity -= 1
								item.quantity += 1
							else:
								if item.quantity >= 1:
									root.cursor_item.quantity += 1
									item.quantity -= 1
					else:
						if root.cursor_item != null:
							item = Item.create(root.cursor_item.item_id, 1)#root.cursor_item
							if (root.cursor_item.quantity - 1) <= 0:
								root.cursor_item = null
							root.cursor_item.quantity -= 1
		
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			if get_global_rect().abs().has_point(event.global_position):
				if root is Inventory:
					if item != null:
						if root.cursor_item == null:
							if item.quantity >= 1:
								root.cursor_item = Item.create_copy(item)#Item.create(item.item_id, item.quantity)
								item.quantity = 0
						else:
							if root.cursor_item.item_id == item.item_id:
								item.quantity += root.cursor_item.quantity
								root.cursor_item = null
							else:
								var replace: Item = item
								item = root.cursor_item
								root.cursor_item = replace
					else:
						if root.cursor_item != null:
							item = root.cursor_item
							root.cursor_item = null
