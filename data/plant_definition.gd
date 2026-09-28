class_name PlantDefinition
extends Resource

@export var plant_id: String = "sunflower"
@export var display_name: String = "Sunflower"
@export enum Rarity { COMMON, UNCOMMON, RARE, LEGENDARY }
@export var rarity: Rarity = Rarity.COMMON
@export_multiline var description: String = "A bright yellow flower that loves the sun."
@export var seed_cost: int = 50
@export var sell_value: int = 120
@export var growth_duration_seconds: float = 60.0
@export var visual_stages: Array[PackedScene] = []