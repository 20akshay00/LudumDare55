extends AudioStreamPlayer2D

const level_music = preload("res://assets/audio/LD55 Loop.wav")

func _play_music(music: AudioStream, volume = -7):
	if stream == music:
		return

	stream = music
	volume_db = volume
	play()

func play_music_level():
	_play_music(level_music)

func play_effect(aud_stream: AudioStream, volume = 0.0):
	var fx_player = AudioStreamPlayer2D.new()
	fx_player.stream = aud_stream
	fx_player.name = "FX_PLAYER"
	fx_player.volume_db = volume
	add_child(fx_player)
	fx_player.play()

	fx_player.finished.connect(fx_player.queue_free)
