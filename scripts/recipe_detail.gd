extends Resource
class_name RecipeDetails

@export var result_id: StringName
@export var result_item: Item
@export var is_unlocked: bool = false

@export var recipe: Array[Item]
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:°C') var min_temp: float
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:°C') var max_temp: float
