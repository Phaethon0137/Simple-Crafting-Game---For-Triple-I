class_name Inventory
extends Control

@onready var slot_container: FlowContainer = %FlowContainer
@onready var toggle_btn: Button = %Button
@onready var anim: AnimationPlayer = %AnimationPlayer
@onready var cursor_item_icon: TextureRect = %CursorItemIcon
@onready var cursor_item_count_lb: Label = %CursorItemCountLb

@onready var item_icon: TextureRect = %ItemIcon
@onready var item_name: Label = %ItemName
@onready var item_comp: Label = %ItemComp
@onready var item_details: RichTextLabel = %ItemDetails

@export var slot_count: int = 68

const INVENTORY_SLOT = preload('uid://bqfr55pya2cd0')

var inv_toggled: bool = false:
	set(i):
		inv_toggled = i
		if inv_toggled:
			anim.play(&'rise')
		else:
			anim.play(&'drop')

var cursor_item: Item
var slots: Array[InventorySlot]
var slot_under_cursor: InventorySlot
var detail_item: Item

func _ready() -> void:
	for n in slot_count:
		var IS: InventorySlot = INVENTORY_SLOT.instantiate()
		slot_container.add_child(IS)
		IS.name = 'InvSlot%s' % [(n + 1)]
		slots.append(IS)
	toggle_btn.button_up.connect(func(): inv_toggled = !inv_toggled)
	if inv_toggled == false:
		anim.play(&'drop_instant')
	else:
		anim.play(&'rise_instant')

	#add_item(Item.create(&'iron', 99))
	#add_item(Item.create(&'carbon', 99))
	#add_item(Item.create(&'carbon', 99))
	for i in ItemDatabase.Items.keys():
		add_item(Item.create(ItemDatabase.Items[i].item_id, 99))



func _process(delta: float) -> void:
	if Input.is_action_just_pressed(&'inv'):
		inv_toggled = !inv_toggled
	
	cursor_item_icon.visible = (cursor_item != null)
	cursor_item_count_lb.visible = (cursor_item != null)
	if cursor_item:
		cursor_item_icon.global_position = cursor_item_icon.global_position.lerp(get_global_mouse_position() + Vector2(8,10),\
		 (delta * 8) * ((get_global_mouse_position().distance_to(cursor_item_icon.global_position) * 0.03)))
		cursor_item_icon.texture = cursor_item.item_icon
		cursor_item_icon.texture_filter = cursor_item.icon_filter
		cursor_item_count_lb.text = str(cursor_item.quantity)
	
	%ItemInfo.visible = (%Control2.get_global_rect().abs().has_point(get_global_mouse_position()) or %Control3.get_global_rect().abs().has_point(get_global_mouse_position()))
	
	if slot_under_cursor != null and slot_under_cursor.item != null:
		detail_item = slot_under_cursor.item
	elif cursor_item != null:
		detail_item = cursor_item
	else:
		detail_item = null
	if detail_item:
		var I: Item = detail_item
		item_icon.texture = I.item_icon
		item_icon.texture_filter = I.icon_filter
		item_name.text = I.item_name
		var text: String = ''
		var item_prop: MaterialProperties = I.properties
		var format: Dictionary = {
			'mass': item_prop.mass,
			'an': item_prop.atomic_number,
			'am': item_prop.atomic_mass,
			'hard': item_prop.hardness,
			'dense': item_prop.density,
			't_str': item_prop.tensile_strength,
			'c_str': item_prop.compressive_strength,
			'elas': item_prop.elasticity,
			'tough': item_prop.toughness,
			'brit': item_prop.brittleness,
			'te': item_prop.thermal_expansion,
			'f_str': item_prop.fatigue_stength,
			'f_tough': item_prop.fracture_toughness,
			'por': item_prop.porosity,
			'mpC': item_prop.melting_point,
			'mpK': Item.C_to_K(item_prop.melting_point),
			'mpF': Item.C_to_F(item_prop.melting_point),
			'mall': item_prop.malleability,
			'ec': item_prop.electric_conductivity,
			'y_str': item_prop.yield_strength,
			'cre_res': item_prop.creep_resistance,
			'cor_res': item_prop.corrosion_resistance,
			'hrd': item_prop.hardenability,
			'duct': item_prop.ductility,
			'weld': item_prop.weldability,
			'grain': item_prop.grain_size,
			'perm': item_prop.permeability,
			'foli': item_prop.foliation,
			'refraC': item_prop.refractory_index,
			'refraK': Item.C_to_K(item_prop.refractory_index),
			'refraF': Item.C_to_F(item_prop.refractory_index),
			'c&f': item_prop.cleavage_and_fracture,
			'fvf': item_prop.fiber_volume_fraction,
			'is_str': item_prop.interlaminar_shear_strength,
			'anis': item_prop.anistropy,
			'mfa': item_prop.matrix_fiber_adhesion,
			'sh_cap': item_prop.specific_heat_capacity,
			'therm_c': item_prop.thermal_conductivity,
			'fire_resC': item_prop.fire_resistance,
			'fire_resK': Item.C_to_K(item_prop.fire_resistance),
			'fire_resF': Item.C_to_F(item_prop.fire_resistance)
		}
		match I.properties.showcase:
			0:
				text = "Mass: {mass} kg\nAtomic Number: {an}\nAtomic Mass: {am} u\n\
				Hardness: {hard}\nDensity: {dense} kg/m³\nTensile Strength: {t_str} MPa\n\
				Compressive Strength: {c_str} MPa\nElasticity: {elas} GPa\nToughness {tough} J/m³\n\
				Brittleness: {brit}\nThermal Expansion: {te} µm/m·°C\nFatigue Strength: {f_str} MPa\n\
				Fracture Toughness: {f_tough} MPa\nPorosity: {por}%\nMelting Point: {mpC}°C ({mpK} | {mpF}°F)\n\
				Malleability: {mall} psi\nElectric Conductivity: {ec} mS/cm\nYield Strength: {y_str} MPa\n\
				Creep Resistance: {cre_res} MPa\nCorrosion Resistance: {cor_res} mm/year\nHardenability: {hrd} HRC\n
				Ductility: {duct}%\nWeldability: {weld} CE\nGrain Size {grain} mm\nPermeability: {perm} D\n\
				Foliation: {foli}\nRefractory Index: {refraC}°C ({refraK} | {refraF}°F)\nCleavage & Fracture: {c&f}\n\
				Fiber Volume Fraction: {fvf}%\nInterlaminar Shear Strength: {is_str} MPa\nAnistropy: {anis} Ratio\n\
				Matrix Fiber Adhesion: {mfa} MPa\nSpecific Heat Capacity: {sh_cap} J/kg·°C\n\
				Thermal Conductivity: {therm_c} W/m·K\nFire Resistance: {fire_resC}°C ({fire_resK} | {fire_resF}°F)"
			1:
				text = "Mass: {mass} kg\nAtomic Mass: {am} u\nHardness: {hard}\nDensity: {dense} kg/m³\nTensile Strength: {t_str} MPa\n\
				Compressive Strength: {c_str} MPa\nElasticity: {elas} GPa\nToughness {tough} J/m³\n\
				Brittleness: {brit}\nThermal Expansion: {te} µm/m·°C\nFatigue Strength: {f_str} MPa\n\
				Fracture Toughness: {f_tough} MPa\nPorosity: {por}%"
			2:
				text = "Atomic Number: {an}\nAtomic Mass: {am} u"
			3:
				text = "Mass: {mass} kg\nAtomic Mass: {am} u\nHardness: {hard}\nDensity: {dense} kg/m³\nTensile Strength: {t_str} MPa\nCompressive Strength: {c_str} MPa\nElasticity: {elas} GPa\nToughness {tough} J/m³\nBrittleness: {brit}\nThermal Expansion: {te} µm/m·°C\nFatigue Strength: {f_str} MPa\nFracture Toughness: {f_tough} MPa\nPorosity: {por}%\nMelting Point: {mpC}°C ({mpK} | {mpF}°F)\nMalleability: {mall} psi\nElectric Conductivity: {ec} mS/cm\nYield Strength: {y_str} MPa\nCreep Resistance: {cre_res} MPa\nCorrosion Resistance: {cor_res} mm/year\nHardenability: {hrd} HRC\nDuctility: {duct}%\nWeldability: {weld} CE\nSpecific Heat Capacity: {sh_cap} J/kg·°C\nThermal Conductivity: {therm_c} W/m·K\nFire Resistance: {fire_resC}°C ({fire_resK} | {fire_resF}°F)"
			4:
				text = "Mass: {mass} kg\nAtomic Number: {an}\nAtomic Mass: {am} u\n\
				Hardness: {hard}\nDensity: {dense} kg/m³\nTensile Strength: {t_str} MPa\n\
				Compressive Strength: {c_str} MPa\nElasticity: {elas} GPa\nToughness {tough} J/m³\n\
				Brittleness: {brit}\nThermal Expansion: {te} µm/m·°C\nFatigue Strength: {f_str} MPa\n\
				Fracture Toughness: {f_tough} MPa\nPorosity: {por}%\nGrain Size {grain} mm\nPermeability: {perm} D\n\
				Foliation: {foli}\nRefractory Index: {refraC}°C ({refraK} | {refraF}°F)\nCleavage & Fracture: {c&f}\nSpecific Heat Capacity: {sh_cap} J/kg·°C\n\
				Thermal Conductivity: {therm_c} W/m·K\nFire Resistance: {fire_resC}°C ({fire_resK} | {fire_resF}°F)"
			5:
				text = "Mass: {mass} kg\nAtomic Number: {an}\nAtomic Mass: {am} u\n\
				Hardness: {hard}\nDensity: {dense} kg/m³\nTensile Strength: {t_str} MPa\n\
				Compressive Strength: {c_str} MPa\nElasticity: {elas} GPa\nToughness {tough} J/m³\n\
				Brittleness: {brit}\nThermal Expansion: {te} µm/m·°C\nFatigue Strength: {f_str} MPa\n\
				Fracture Toughness: {f_tough} MPa\nPorosity: {por}%\nFiber Volume Fraction: {fvf}%\nInterlaminar Shear Strength: {is_str} MPa\nAnistropy: {anis} Ratio\n\
				Matrix Fiber Adhesion: {mfa} MPa\nSpecific Heat Capacity: {sh_cap} J/kg·°C\n\
				Thermal Conductivity: {therm_c} W/m·K\nFire Resistance: {fire_resC}°C ({fire_resK} | {fire_resF}°F)"
			
		item_details.text = text.format(format)
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if cursor_item_icon.visible == false:
				cursor_item_icon.global_position = event.global_position + Vector2(-32,-32)
	if event is InputEventMouseMotion:
		if not $Control.get_global_rect().abs().has_point(event.global_position): 
			slot_under_cursor = null
			return
		for slot in slots:
			if slot.get_global_rect().abs().has_point(event.global_position):
				slot_under_cursor = slot

func find_free_slot() -> InventorySlot:
	if slots.is_empty(): return null
	return slots.filter(func(a): if a.item == null: return a)[0]

func add_item(item: Item) -> void:
	if slots.is_empty(): return
	for s in slots:
		if s.item != null:
			if s.item == item:
				s.item.quantity += item.quantity
				return
	find_free_slot().item = Item.create(item.item_id, item.quantity)
