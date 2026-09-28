class_name VisitorDefinition
extends Resource

## Data-driven resource defining a garden visitor (butterfly, bird, special character, etc.)

@export var visitor_id: String = "blue_butterfly"
@export var display_name: String = "Blue Butterfly"
@export_multiline var description: String = "A gentle visitor attracted to blooming flowers."
@export var visitor_scene: PackedScene
@export var rarity: int = 0 # 0: Common, 1: Uncommon, etc.