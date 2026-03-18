extends Node

@onready var items: Dictionary[StringName, Item] = {
	&'iron': load('uid://c4imqy2xni62k'),
	&'carbon': load('res://items/Carbon.tres')
}

var Items: Dictionary[String,Item] = {}
var Recipes: Dictionary[String,RecipeDetails] = {}

func _ready() -> void:
	var i: PackedStringArray = DirAccess.get_files_at('res://items/')
	for p in i:
		var path: String = 'res://items/' + p
		var res: Item = load(path)
		Items.merge({res.item_id: res})
	var j: PackedStringArray = DirAccess.get_files_at('res://recipes/')
	for p in j:
		var path: String = 'res://recipes/' + p
		var res: RecipeDetails = load(path)
		Recipes.merge({res.result_item.item_id: res})
