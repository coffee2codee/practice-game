extends Control

@onready var coin_label: Label = $MarginContainer/HBoxContainer/CoinLabel
@onready var fertilizer_label: Label = $MarginContainer/HBoxContainer/FertilizerLabel

func _ready() -> void:
	# Connect to GameManager signals to update UI dynamically
	GameManager.connect("coins_changed", Callable(self, "_on_coins_changed"))
	GameManager.connect("fertilizer_changed", Callable(self, "_on_fertilizer_changed"))
	
	# Set initial values
	coin_label.text = "Coins: " + str(GameManager.coins)
	fertilizer_label.text = "Fertilizer: " + str(GameManager.fertilizer)

func _on_coins_changed(new_amount: int) -> void:
	coin_label.text = "Coins: " + str(new_amount)

func _on_fertilizer_changed(new_amount: int) -> void:
	fertilizer_label.text = "Fertilizer: " + str(new_amount)