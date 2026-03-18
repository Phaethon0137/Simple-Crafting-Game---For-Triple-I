class_name Item
extends Resource

@export var item_id: StringName
@export var item_name: String
@export var item_icon: Texture2D
@export var icon_filter: Control.TextureFilter = Control.TEXTURE_FILTER_LINEAR
@export var quantity: int = 0

@export var properties: MaterialProperties = preload('uid://baulv0o6gap0e')

var dict = {'mass': 0.0,'hardness': 0.0,	'density': 0.0,'t_strength': 0.0,'melting_point': 0.0,'conductivity': 0.0,'malleability': 0.0,'elasticity': 0.0,'toughness': 0.0,'brittleness': 0.0}

static func create(id: StringName, count: int = 1, custom_name: String = '') -> Item:
	var n: Item = Item.new()
	if id in ItemDatabase.Items:
		n.item_id = id
		if custom_name.is_empty():
			n.item_name = ItemDatabase.Items[id].item_name
		else:
			if not custom_name.contains('prefix:') or not custom_name.contains('suffix:'):
				n.item_name = custom_name
			else:
				if custom_name.contains('prefix:'):
					n.item_name = custom_name.remove_chars('prefix:') + ItemDatabase.Items[id].item_name
				if custom_name.contains('suffix:'):
					n.item_name += custom_name.remove_chars('suffix:')
	
		n.item_icon = ItemDatabase.Items[id].item_icon
		n.icon_filter = ItemDatabase.Items[id].icon_filter
		n.properties = ItemDatabase.Items[id].properties
		n.quantity = count
		return n
	return null

static func create_copy(item: Item, custom_quantity: int = -1) -> Item:
	var n: Item = Item.new()
	n.item_id = item.item_id
	n.item_icon = item.item_icon
	n.icon_filter = item.icon_filter
	n.item_name = item.item_name
	n.properties = item.properties
	if custom_quantity > 0:
		n.quantity = custom_quantity
	else:
		n.quantity = item.quantity
	return n

static func create_new(id: StringName, new_properties: Dictionary = {}, new_quantity: int = 0, custom_name: String = '') -> Item:
	var i: Item = Item.new()
	i.item_id = id
	i.item_icon = ItemDatabase.Items[id].item_icon
	i.icon_filter = ItemDatabase.Items[id].icon_filter
	for p in new_properties:
		i.properties[p] = new_properties[p]
	i.quantity = new_quantity
	if custom_name.is_empty():
		i.item_name = ItemDatabase.Items[id].item_name
	else:
		i.item_name = custom_name
	return i

static func C_to_K(C: float) -> float:
	return C + 273.15
static func C_to_F(C: float) -> float:
	return (C * 1.8) + 32 # 9/5 = 1.8
