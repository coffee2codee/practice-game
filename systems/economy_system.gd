class_name EconomySystem
extends Node

## Manages economic transactions like seed purchases and harvest sales via GameManager.

func can_afford(cost: int) -> bool:
	return GameManager.coins >= cost

func buy_seed(seed_cost: int) -> bool:
	if can_afford(seed_cost):
		GameManager.spend_coins(seed_cost)
		AudioManager.play_sfx(null) # Placeholder for coin sound effect
		return true
	return false

func sell_harvest(sell_value: int) -> void:
	GameManager.add_coins(sell_value)
	AudioManager.play_sfx(null) # Placeholder for coin sound effect