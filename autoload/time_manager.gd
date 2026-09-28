class_name TimeManager
extends Node

signal time_advanced(delta_seconds: float)

func get_current_unix_time() -> float:
	return Time.get_unix_time_from_system()

func get_elapsed_time(saved_timestamp: float) -> float:
	var elapsed = get_current_unix_time() - saved_timestamp
	return max(0.0, elapsed)