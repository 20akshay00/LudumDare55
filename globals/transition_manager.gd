extends CanvasLayer

@onready var sound_enter = preload("res://assets/audio/LD55 Enter Level.wav")
@onready var sound_complete = preload("res://assets/audio/LD55 Complete Level.wav")

func _ready() -> void:
	layer = 2
	
func change_scene(target : PackedScene) -> void:
	AudioManager.play_effect(sound_complete, 0)
	var tween = get_tree().create_tween()
	tween.tween_property($ColorRect, "modulate:a", 1., 1)
	tween.tween_callback(func(): get_tree().change_scene_to_packed(target))
	tween.tween_property($ColorRect, "modulate:a", 0., 1)	
	
func reload_scene() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($ColorRect, "modulate:a", 1., 1)
	tween.tween_callback(func(): get_tree().reload_current_scene())
	tween.tween_property($ColorRect, "modulate:a", 0., 1)	
