class_name Breakable
extends StaticBody2D

@export var health = 1
@onready var break_fx = preload("res://assets/audio/LD55 Block Break_.wav")

func break_self() -> void:
	health -= 1
	if health == 0:
		AudioManager.play_effect(break_fx, -3)
		Events.wall_broken.emit(position)
		$CollisionShape2D.queue_free()
		$GPUParticles2D.emitting = true
		
		var tween = get_tree().create_tween()
		tween.parallel().tween_property($Sprite2D, "modulate:a", 0., 0.3)
		tween.parallel().tween_property($GPUParticles2D, "modulate:a", 0., 0.7)	
		tween.tween_callback(queue_free)
		
	
