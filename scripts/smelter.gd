extends Control

@onready var ingredient_container: Control = %IngredientContainer
@onready var smelt_btn: Button = %SmeltBtn
@onready var temp_slider: HSlider = %TempSlider
@onready var temp_lb: Label = %TempLb
@onready var result: InventorySlot = %Result
@onready var target_temp_lb: Label = %TargetTempLb

@onready var item_a: InventorySlot = %ItemA
@onready var item_b: InventorySlot = %ItemB
@onready var item_c: InventorySlot = %ItemC
@onready var item_d: InventorySlot = %ItemD

var temp: float = 0.0
var target_temp: float = 0.0
var prev_tween: Tween

func _ready() -> void:
	smelt_btn.pressed.connect(smelt)
	temp_slider.drag_ended.connect(tween_temp)

func _process(_delta: float) -> void:
	target_temp = temp_slider.value
	temp_lb.text = 'Temp: %s°C (%s K | %s°F)' % [int(temp), str(C_to_K(temp)).pad_decimals(2), int(C_to_F(temp))]# + str(int(temp_slider.value))
	target_temp_lb.text = 'Target: %s°C (%s K | %s°F)' % [int(target_temp), str(C_to_K(target_temp)).pad_decimals(2), int(C_to_F(target_temp))]

func smelt() -> void:
	var container: Array = ingredient_container.get_children()
	for r in ItemDatabase.Recipes.values():
		if r.recipe.size() == container.filter(func(a): if a is InventorySlot and a.item != null: return a).size():
			if has_items(r.recipe).size() == r.recipe.size():
				if temp >= r.min_temp and temp <= r.max_temp:
					result.item = Item.create_copy(r.result_item, 99)

#func old_smelt() -> void:
#	#print('test')
#	# Iron-Steel Alloy
#	if temp >= 900 and temp < 1190:
#		if has_item(&'iron'):
#			if result.item != null:
#				result.item.quantity += 1
#			else:
#				var new: Item = Item.create_new(&'steel', {'mass': 4.2,'hardness': 7,'density':7820,'t_strength':160000,\
#				'melting_point': 1480,'conductivity':55000,'malleability':60000,'elasticity': 205,'toughness':7e7,'brittleness':0.30},\
#				1, 'Cast Iron (Fe)')
#				result.item = Item.create_copy(new, 1)
#		
#	if temp >= 1200 and temp < 1400:
#		if has_item(&'iron').quantity > 0 and has_item(&'carbon').quantity > 0:
#			if not has_item(&'titanium') and not has_item(&'cobalt') and not has_item(&'tungsten'):
#				if result.item != null:
#					result.item.quantity += 1
#				else:
#					result.item = Item.create(&'steel')
#			if has_item(&'titanium') and not has_item(&'cobalt') and not has_item(&'tungsten'):
#				if result.item != null:
#					result.item.quantity += 1
#				else:
#					var new: Item = Item.create_new(&'steel', {'mass': 4.2,'hardness': 7,'density':7820,'t_strength':160000,\
#					'melting_point': 1480,'conductivity':55000,'malleability':60000,'elasticity': 205,'toughness':7e7,'brittleness':0.30},\
#					1, 'Titanium-Alloyed Steel (Fe-C-Ti)')
#					result.item = Item.create_copy(new, 1)
#			if has_item(&'titanium') and not has_item(&'cobalt') and has_item(&'tungsten'):
#				if result.item != null:
#					result.item.quantity += 1
#				else:
#					var new: Item = Item.create_new(&'steel', {'mass': 5.1,'hardness': 7.5,'density':7950,'t_strength':200000,\
#					'melting_point': 1500,'conductivity':50000,'malleability':75000,'elasticity': 210,'toughness':6e7,'brittleness':0.40},\
#					1, 'Titanium-Tungsten Steel (Fe-C-Ti-W)')
#					result.item = Item.create_copy(new, 1)
#			if not has_item(&'titanium') and has_item(&'cobalt') and not has_item(&'tungsten'):
#				if result.item != null:
#					result.item.quantity += 1
#				else:
#					var new: Item = Item.create_new(&'steel', {'mass': 4.3,'hardness': 6.5,'density':7900,'t_strength':170000,\
#					'melting_point': 1470,'conductivity':58000,'malleability':60000,'elasticity': 205,'toughness':6.5e7,'brittleness':0.32},\
#					1, 'Cobalt-Alloyed Steel (Fe-C-Co)')
#					result.item = Item.create_copy(new, 1)
#			if not has_item(&'titanium') and has_item(&'cobalt') and has_item(&'tungsten'):
#				if result.item != null:
#					result.item.quantity += 1
#				else:
#					var new: Item = Item.create_new(&'steel', {'mass': 4.6,'hardness': 7.8,'density':8100,'t_strength':220000,\
#					'melting_point': 1520,'conductivity':48000,'malleability':80000,'elasticity': 215,'toughness':6.8e7,'brittleness':0.42},\
#					1, 'Cobalt-Tungsten Steel (Fe-C-Co-W)')
#					result.item = Item.create_copy(new, 1)
#					#result.item = Item.create(&'steel', 1, 'Steel (+CoW)')
#			if has_item(&'titanium') and has_item(&'cobalt') and not has_item(&'tungsten'):
#				if result.item != null:
#					result.item.quantity += 1
#				else:
#					var new: Item = Item.create_new(&'steel', {'mass': 4.5,'hardness': 7,'density':7880,'t_strength':190000,\
#					'melting_point': 1480,'conductivity':53000,'malleability':70000,'elasticity': 208,'toughness':7.2e7,'brittleness':0.33},\
#					1, 'Titanium-Cobalt Steel (Fe-C-Ti-Co)')
#					result.item = Item.create_copy(new, 1)
#					#result.item = Item.create(&'steel', 1, 'Steel (+TiCo)')
#			if has_item(&'titanium') and has_item(&'cobalt') and has_item(&'tungsten'):
#				if result.item != null:
#					result.item.quantity += 1
#				else:
#					var new: Item = Item.create_new(&'steel', {'mass': 5.0,'hardness': 8,'density':8200,'t_strength':250000,\
#					'melting_point': 1540,'conductivity':45000,'malleability':90000,'elasticity': 220,'toughness':7.5e7,'brittleness':0.45},\
#					1, 'Titanium-Cobalt-Tungsten Steel (Fe-C-Ti-Co-W)')
#					result.item = Item.create_copy(new, 1)
#					#result.item = Item.create(&'steel', 1, 'Steel (+TiCoW)')
#	
#	if temp >= 1450 and temp < 1600:
#		if has_item(&'iron').quantity > 0 and has_item(&'carbon').quantity > 0 and has_item(&'chromium').quantity > 0:
#			if has_item(&''): pass
#			if result.item != null:
#				result.item.quantity += 1
#			else:
#				result.item = Item.create(&'stainless_steel')

func C_to_K(C: float) -> float:
	return C + 273.15
func C_to_F(C: float) -> float:
	return (C * 1.8) + 32 # 9/5 = 1.8

func has_item(id: StringName) -> Item:
	var container: Array = ingredient_container.get_children()
	var r: Item = null
	for i in container.filter(func(a): if a is InventorySlot and a.item != null and a.item.item_id == id: return a):
		#print(i)
		if i.item != null:
			if r == null:
				r = i.item
			else:
				if i.item.item_id == r.item_id:
					r.quantity += i.item.quantity
	#sprint(r)
	return r

func has_items(array: Array[Item]) -> Array[Item]:
	var container: Array = ingredient_container.get_children()
	var results: int = 0
	var r: Array[Item] = []
	#print(container.filter(func(a): if a is InventorySlot and a.item != null: return a).size(), '/', array.size())
	if array.size() == container.filter(func(a): if a is InventorySlot and a.item != null: return a).size():
		for i in container.filter(func(a): if a is InventorySlot and a.item != null: return a):
			if array[results].item_id == i.item.item_id:
				r.append(i.item)
				results += 1
			
	print(r)
	return r

func tween_temp(_v: bool) -> void:
	if prev_tween:
		prev_tween.stop()
	prev_tween = create_tween()
	if temp > temp_slider.value:
		if temp_slider.value > 0:
			prev_tween.tween_property(self,^'temp',temp_slider.value, 1.0 * (1 + ((temp / temp_slider.value) * 0.5))).set_trans(Tween.TRANS_QUAD)
		else:
			prev_tween.tween_property(self,^'temp',temp_slider.value, 3.2).set_trans(Tween.TRANS_QUAD)
	else:
		if temp_slider.value > 0:
			prev_tween.tween_property(self,^'temp',temp_slider.value, 2.1 * (1 + ((temp / temp_slider.value) * 0.5))).set_trans(Tween.TRANS_QUAD)
		else:
			prev_tween.tween_property(self,^'temp',temp_slider.value, 3.2).set_trans(Tween.TRANS_QUAD)
