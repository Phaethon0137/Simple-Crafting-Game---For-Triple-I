class_name MaterialProperties
extends Resource

## Only display the selected properties.
@export_enum('All', 'Universal-Only', 'Element', 'Metal-Specific', 'Rock/Ceramic-Specific', 'Composite-Specific') var showcase: int = 0

## The mass of the material based on real world object volume.
## In Kilograms (kg).
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:kg') var mass: float = 0.0
## The atomic number of the element (leave -1 if its a product instead of a raw element)
@export var atomic_number: int = 0
## Total mass of a single atom. Commonly found in Periodic Table of Elements. 
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:u') var atomic_mass: float = 0
## A property which determines the material's ability to resist permenant deformation, such as scratches, indentation, or abrasion. 
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.01, 'suffix:Mohs') var hardness: float = 0.0
## The measure of how much mass is packed into a given volume or space.
## Calculated by dividing an object's mass by its volume.
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:kg/m³') var density: float = 0.0
## The maximum amount of tensile (pulling) stress a material can withstand before breaking or failing.
## In Megapascals (MPa).
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:MPa') var tensile_strength: float = 0.0

@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:MPa') var compressive_strength: float = 0.0 ## Megapascals
## The material's ability to return to its original shape and size after deforming forces are removed.
## In Gigapascals (GPa).
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:GPa') var elasticity: float = 0.0
## The material's ability to absorb energy and plastically deform without fracturing, 
## combining high strength and ductility.
## In Joules per cubic meter (J/m³).
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:J/m³') var toughness: float = 0.0
## The tendency of the material to break, snap, or crack without significant deformation
## (bending or stretching) when subjected to stress.
## In index.
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:BI') var brittleness: float = 0.0
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:µm/m·°C') var thermal_expansion: float = 0.0
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:MPa') var fatigue_stength: float = 0.0
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:MPa·√m') var fracture_toughness: float = 0.0
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:%') var porosity: float = 0.0

@export_group('Metal-Specific')
## The specific temperature at which a material/substance melts or in scientific term changes state from solid to liquid. In Celsius.
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:°C') var melting_point: float = 0.0
## The physical property of a material, particularly metals. 
## It is the ability to be shaped, hammered, or rolled into thin sheets without breaking.
## In pound per square inch (psi).
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:psi') var malleability: float = 0.0
## The material's ability to allow the flow of electric charge. 
## In milliSiemens per centimeter (mS/cm).
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:mS/cm') var electric_conductivity: float = 0.0
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:MPa') var yield_strength: float = 0.0
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:MPa') var creep_resistance: float = 0.0
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:mm/year') var corrosion_resistance: float = 0.0
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:HRC') var hardenability: float = 0.0 ## Rockwell C (HRC)
## The physical property of a material, particularly metals.
## It is the ability to deform permenantly under tensile stress—such as being stretch into thin wire or drawn out—without breaking.
## In % Elongation.
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:%') var ductility: float = 0.0
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:CE') var weldability: float = 0.0 ## Carbon Equivalent (CE)

@export_group('Rock|Ceramic-Specific')
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:mm') var grain_size: float = 0.0
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:D') var permeability: float = 0.0 ## In Darcy (D)
@export_multiline() var foliation: String ## Qualitative
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:°C') var refractory_index: float = 0.0
@export_multiline() var cleavage_and_fracture: String

@export_group('Composite-Specific')
@export_range(0.0,100.0,0.001, 'suffix:%', 'or_greater') var fiber_volume_fraction: float = 0.0
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:MPa') var interlaminar_shear_strength: float = 0.0
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:Ratio') var anistropy: float = 0.0
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:MPa') var matrix_fiber_adhesion: float = 0.0

@export_group('Thermal')
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:J/kg·°C') var specific_heat_capacity: float = 0.0
## The material's ability to allow the flow of heat. In Watts per meter-Kelvin (W/m·K).
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:W/m·K') var thermal_conductivity: float = 0.0
@export_range(-0xFFFFFFFF,0xFFFFFFFF,0.001, 'suffix:°C') var fire_resistance: float = 0.0
