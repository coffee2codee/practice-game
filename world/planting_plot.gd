class_name PlantingPlot
extends Node3D

signal plot_clicked(plot: PlantingPlot)

@export var plot_id: String = "plot_01"
var current_plant_data = null
var is_occupied: bool = false

func _ready() -> void:
	# Placeholder interaction setup
	pass

func _unhandled_input(_camera: Camera3D, event: InputEvent, _position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("plot_clicked", self)