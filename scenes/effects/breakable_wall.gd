class_name Breakable
extends StaticBody2D

@export var health = 2

func break_self() -> void:
	health -= 1
	if health == 0:
		Events.wall_broken.emit(position)
		$CollisionShape2D.queue_free()
		$GPUParticles2D.emitting = true
		
		var tween = get_tree().create_tween()
		tween.parallel().tween_property($Sprite2D, "modulate:a", 0., 0.3)
		tween.parallel().tween_property($GPUParticles2D, "modulate:a", 0., 0.7)	
		tween.tween_callback(queue_free)
		
	
