extends CharacterBody2D

@onready var arena: TileMap = get_parent()
@export var SPEED: float = 2
@onready var sound_fx = preload("res://assets/audio/LD55 Skelly.wav")

func _ready() -> void:
	pass # Replace with function body.
	
func _process(_delta: float) -> void:
	var collision = move_and_collide(velocity)
	if collision:
		var body = collision.get_collider()
		var tile_fireball = get_parent().local_to_map(position)
		var tile_body = get_parent().local_to_map(body.position)
		
		if "summon_name" in body:
			if body.summon_name == "skeleton":
				var cur_dir = velocity.normalized()
				if cur_dir.dot(body.direction) == 1:
					if velocity.dot(tile_fireball - tile_body) != 0:
						body.on_death()
				elif cur_dir.dot(body.direction) == -1:
					on_death()
				else:
					AudioManager.play_effect(sound_fx, -5)
					velocity = SPEED * body.direction
			else:
				if velocity.dot(tile_fireball - tile_body) != 0:
					body.on_death()
		else:
			on_death()

func launch(dir: Vector2) -> void:
	velocity = SPEED * dir
	
func on_death() -> void:
	$CollisionShape2D.queue_free()
	$GPUParticles2D.emitting = true
	velocity = Vector2(0, 0)
	var tween = get_tree().create_tween()
	tween.parallel().tween_property($Sprite2D, "modulate:a", 0., 0.3)
	tween.parallel().tween_property($GPUParticles2D, "modulate:a", 0., 0.7)	
	tween.tween_callback(queue_free)
	
