class_name WeatherSystem
extends Node

## Manages environmental weather states (Clear, Rain, Wind, Fog) for the garden world.

enum WeatherType { CLEAR, RAIN, WIND, FOG }

signal weather_changed(new_weather: WeatherType)

@export var current_weather: WeatherType = WeatherType.CLEAR:
	set(val):
		current_weather = val
		emit_signal("weather_changed", current_weather)
		_apply_weather_effects(current_weather)

func set_weather(weather: WeatherType) -> void:
	current_weather = weather

func _apply_weather_effects(weather: WeatherType) -> void:
	match weather:
		WeatherType.CLEAR:
			# Adjust environment lighting / stop rain particles
			pass
		WeatherType.RAIN:
			# Trigger rain particle effects and adjust ambient audio
			AudioManager.play_ambience(null) # Placeholder for rain audio stream
			pass
		WeatherType.WIND:
			# Increase foliage sway intensity
			pass
		WeatherType.FOG:
			# Enable atmospheric fog in WorldEnvironment
			pass