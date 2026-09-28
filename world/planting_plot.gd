class_name PlantingPlot
extends StaticBody3D

signal plot_clicked(plot: PlantingPlot)

@export var plot_id: String = "plot_01"

var current_plant_node: BasePlant = null
var is_occupied: bool = false

@onready var plant_spawn_marker: Node3D = $PlantSpawnMarker if has_node("PlantSpawnMarker") else self

func _ready() -> void:
	# Ensure we can detect input events on this 3D object
	input_ray_pickable = true

# Called when the player clicks/taps this 3D plot
func _input_event(_camera: Camera3D, event: InputEvent, _position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_on_plot_interacted()
	elif event is InputEventScreenTouch and event.pressed:
		_on_plot_interacted()

func _on_plot_interacted() -> void:
	emit_signal("plot_clicked", self)
	
	if not is_occupied:
		# Test planting a sunflower using our TimeManager and PlantDefinition
		# (We will connect this to a seed selection menu later!)
		pass
	else:
		if current_plant_node and current_plant_node.is_ready_to_harvest():
			harvest_plant()

func plant_seed(definition: PlantDefinition, base_plant_scene: PackedScene) -> void:
	if is_occupied or not definition:
		return
		
	is_occupied = true
	var plant_instance = base_plant_scene.instantiate() as BasePlant
	plant_spawn_marker.add_child(plant_instance)
	
	var current_time = TimeManager.get_current_unix_time()
	plant_instance.initialize(definition, current_time)
	current_plant_node = plant_instance

func harvest_plant() -> void:
	if not is_occupied or not current_plant_node:
		return
		
	# Reward coins through our Economy/GameManager systems
	if current_plant_node.plant_definition:
		GameManager.add_coins(current_plant_node.plant_definition.sell_value)
		AudioManager.play_sfx(null) # Play harvest sfx here later
		
	current_plant_node.queue_free()
	current_plant_node = null
	is_occupied = false