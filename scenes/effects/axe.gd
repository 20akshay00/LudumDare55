extends CharacterBody2D

@export var anchor: Vector2 
@export var stride := Vector2(3, 0)
@export var tile_size: int = 98
@export var SPEED: float = 300
@export var direction := Vector2(1, 0)

@onready var freeze_fx = preload("res://assets/audio/LD55 Freezy.wav")
@onready var skeleton_fx = preload("res://assets/audio/LD55 Skelly.wav")

func _ready() -> void:
	anchor = position
	velocity = SPEED * direction
	
func _process(delta: float) -> void:
	if position <= anchor - tile_size * stride:
		velocity.x = -velocity.x
		position.x = position.x + 2.
	if position >= anchor + tile_size * stride:
		velocity.x = -velocity.x
		position.x = position.x - 2.
		
	var collision = move_and_collide(delta * velocity)
	if collision:
		var body = collision.get_collider()
		if body is TileMap:
			velocity.x = -velocity.x
		elif "summon_name" in body:
			if body.summon_name == "skeleton":
				if snappedf(velocity.dot(body.direction), 0.001) < 0:
					velocity.x = -velocity.x
					AudioManager.play_effect(skeleton_fx, 0)
				else:
					body.on_death()
			elif body.summon_name == "elemental":
				AudioManager.play_effect(freeze_fx, 0)
				direction = velocity.normalized()
				velocity.x = 0
				var tween = get_tree().create_tween()
				tween.parallel().tween_property($Base, "modulate:a", 0., 1)
				tween.parallel().tween_property($Frozen, "modulate:a", 1., 1)
			else:
				body.on_death()
		else:
			body.on_death()
