class_name GrowthSystem
extends Node

## Calculates plant stage progression and checks if a plant is ready for harvest.

func calculate_current_stage(planted_timestamp: float, growth_duration: float, total_stages: int) -> int:
	var elapsed = TimeManager.get_elapsed_time(planted_timestamp)
	if elapsed >= growth_duration:
		return total_stages - 1 # Fully grown / bloom stage
	
	if total_stages <= 1:
		return 0
		
	var time_per_stage = growth_duration / float(total_stages - 1)
	var stage = int(elapsed / time_per_stage)
	return clampi(stage, 0, total_stages - 1)

func is_harvest_ready(planted_timestamp: float, growth_duration: float) -> bool:
	return TimeManager.get_elapsed_time(planted_timestamp) >= growth_duration