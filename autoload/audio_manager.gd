extends Node

@onready var sfx_player: AudioStreamPlayer = AudioStreamPlayer.new()
@onready var ambience_player: AudioStreamPlayer = AudioStreamPlayer.new()

func _ready() -> void:
	add_child(sfx_player)
	add_child(ambience_player)

func play_sfx(stream: AudioStream, pitch_scale: float = 1.0) -> void:
	if stream:
		sfx_player.stream = stream
		sfx_player.pitch_scale = pitch_scale
		sfx_player.play()

func play_ambience(stream: AudioStream) -> void:
	if stream and not ambience_player.playing:
		ambience_player.stream = stream
		ambience_player.autoplay = true
		ambience_player.play()

func stop_ambience() -> void:
	ambience_player.stop()