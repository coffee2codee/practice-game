extends Node

signal coins_changed(new_amount: int)
signal fertilizer_changed(new_amount: int)

@export var coins: int = 500:
	set(val):
		coins = val
		emit_signal("coins_changed", coins)

@export var fertilizer: int = 4:
	set(val):
		fertilizer = val
		emit_signal("fertilizer_changed", fertilizer)

func add_coins(amount: int) -> void:
	coins += amount

func spend_coins(amount: int) -> bool:
	if coins >= amount:
		coins -= amount
		return true
	return false