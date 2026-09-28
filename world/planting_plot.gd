class_name PlantingPlot
extends StaticBody3D

signal plot_clicked(plot: PlantingPlot)

@export var is_occupied: bool = false
var current_plant_node: Node3D = null

@onready var plant_spawn_marker: Node3D = self

func _ready() -> void:
	pass

# Bulletproof click detection using a camera raycast
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var camera = get_viewport().get_camera_3d()
		if not camera:
			return
		
		var mouse_pos = get_viewport().get_mouse_position()
		var ray_origin = camera.project_ray_origin(mouse_pos)
		var ray_normal = camera.project_ray_normal(mouse_pos)
		var ray_end = ray_origin + ray_normal * 1000.0
		
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
		query.collide_with_bodies = true
		
		var result = space_state.intersect_ray(query)
		if result and result.collider == self:
			_on_plot_interacted()

func _on_plot_interacted() -> void:
	emit_signal("plot_clicked", self)
	
	if not is_occupied:
		var sunflower_def = load("res://data/content/plants/sunflower_def.tres") as PlantDefinition
		if sunflower_def:
			plant_seed_dynamic(sunflower_def)
	else:
		if current_plant_node and current_plant_node.has_method("is_ready_to_harvest") and current_plant_node.is_ready_to_harvest():
			harvest_plant()

func plant_seed_dynamic(definition: PlantDefinition) -> void:
	if is_occupied or not definition:
		return
		
	is_occupied = true
	
	# Create a BasePlant node via code directly
	current_plant_node = BasePlant.new() if ClassDB.class_exists("BasePlant") else Node3D.new()
	plant_spawn_marker.add_child(current_plant_node)
	
	# Add a temporary visual mesh (a little sphere) so we can see the plant on the plot!
	var visual_mesh = MeshInstance3D.new()
	var sphere = SphereMesh.new()
	sphere.radius = 0.3
	sphere.height = 0.6
	visual_mesh.mesh = sphere
	visual_mesh.position.y = 0.4 # Sit nicely on top of the soil
	current_plant_node.add_child(visual_mesh)
	
	if current_plant_node.has_method("initialize"):
		current_plant_node.initialize(definition, 0)
		
	print("Planted Sunflower successfully!")

func harvest_plant() -> void:
	if current_plant_node:
		current_plant_node.queue_free()
		current_plant_node = null
		is_occupied = false
		print("Harvested plant successfully!")
