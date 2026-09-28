class_name PlantingPlot
extends Node3D

signal plot_clicked(plot: PlantingPlot)

@export var plot_id: String = "plot_01"
var current_plant_data = null
var is_occupied: bool = false

func _unhandled_input(event: InputEvent) -> void:
	# Handled globally or via area input signals
	pass