class_name BasePlant
extends Node3D

@export var plant_definition: PlantDefinition

var planted_timestamp: float = 0.0
var current_stage: int = -1
var growth_system: GrowthSystem = GrowthSystem.new()

func initialize(definition: PlantDefinition, timestamp: float) -> void:
	plant_definition = definition
	planted_timestamp = timestamp
	update_visuals_for_stage(0)

func _process(_delta: float) -> void:
	if not plant_definition:
		return
		
	var target_stage = growth_system.calculate_current_stage(
		planted_timestamp, 
		plant_definition.growth_duration_seconds, 
		plant_definition.visual_stages.size()
	)
	
	if target_stage != current_stage:
		update_visuals_for_stage(target_stage)

func update_visuals_for_stage(stage: int) -> void:
	current_stage = stage
	
	# Clear previous visual model children
	for child in get_children():
		child.queue_free()
		
	# Instantiate the new visual stage packed scene if available
	if plant_definition and stage < plant_definition.visual_stages.size():
		var scene_to_spawn = plant_definition.visual_stages[stage]
		if scene_to_spawn:
			var instance = scene_to_spawn.instantiate()
			add_child(instance)

func is_ready_to_harvest() -> bool:
	if not plant_definition:
		return false
	return growth_system.is_harvest_ready(planted_timestamp, plant_definition.growth_duration_seconds)