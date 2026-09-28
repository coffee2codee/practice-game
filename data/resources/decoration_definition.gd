class_name DecorationDefinition
extends Resource

## Data-driven resource defining a placable garden decoration (bench, lantern, fountain, etc.)

@export var decoration_id: String = "wooden_bench"
@export var display_name: String = "Wooden Bench"
@export_multiline var description: String = "A cozy spot for visitors to rest in the garden."
@export var cost: int = 150
@export var decoration_scene: PackedScene
@export var category: String = "Furniture"