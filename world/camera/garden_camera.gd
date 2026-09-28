class_name GardenCamera
extends Camera3D

## Smooth isometric-inspired 3D camera controller for touch and mouse interaction.

@export var pan_speed: float = 0.005
@export var zoom_speed: float = 0.1
@export var min_zoom: float = 5.0
@export var max_zoom: float = 25.0

var target_position: Vector3

func _ready() -> void:
	target_position = global_position

func _unhandled_input(event: InputEvent) -> void:
	# Handle mouse drag panning or touch panning
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
		var motion := event.relative as Vector2
		transform.origin.x -= motion.x * pan_speed
		transform.origin.z -= motion.y * pan_speed

	# Handle zoom (scroll wheel)
	elif event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				zoom(-1.0)
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				zoom(1.0)

func zoom(direction: float) -> void:
	var current_pos := global_position
	var forward := -global_transform.basis.z.normalized()
	var new_pos = current_pos + forward * (direction * zoom_speed * 10.0)
	
	# Clamp zoom distance limits
	if new_pos.y >= min_zoom and new_pos.y <= max_zoom:
		global_position = new_pos