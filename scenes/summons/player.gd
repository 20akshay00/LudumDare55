class_name Player
extends CharacterBody2D

@onready var sound_death = preload("res://assets/audio/LD55 Death.wav")

func on_death() -> void:
	$CollisionShape2D.queue_free()
	$GPUParticles2D.emitting = true
	
	AudioManager.play_effect(sound_death, 0)
	var tween = get_tree().create_tween()
	tween.parallel().tween_property($Sprite2D, "modulate:a", 0., 0.3)
	tween.parallel().tween_property($GPUParticles2D, "modulate:a", 0., 0.7)	
	tween.tween_callback(queue_free)
