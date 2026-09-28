extends Node

const SAVE_FILE_PATH := "user://gardengame_save.json"

func save_game_data(player_data: Dictionary) -> void:
	var json_string := JSON.stringify(player_data)
	var file := FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(json_string)

func load_game_data() -> Dictionary:
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		return {} 
	
	var file := FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	var json_string := file.get_as_text()
	var json := JSON.new()
	var error := json.parse(json_string)
	
	if error == OK:
		return json.get_data() as Dictionary
	return {}