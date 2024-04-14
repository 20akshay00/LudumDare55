extends CharacterBody2D

@export var anchor: Vector2 
@export var stride := Vector2(3, 0)
@export var tile_size: int = 98
@export var SPEED: float = 300
@export var direction := Vector2(1, 0)

func _ready() -> void:
	anchor = position
	velocity = SPEED * direction
	
func _process(delta: float) -> void:
	if position <= anchor - tile_size * stride:
		velocity.x = -velocity.x
	if position >= anchor + tile_size * stride:
		velocity.x = -velocity.x

	var collision = move_and_collide(delta * velocity)
	if collision:
		var body = collision.get_collider()
		if body is TileMap:
			velocity.x = -velocity.x
		elif "summon_name" in body:
			print(body.summon_name)
			if body.summon_name == "skeleton":
				print(velocity.dot(body.direction))
				if snappedf(velocity.dot(body.direction), 0.001) < 0:
					velocity.x = -velocity.x
				else:
					body.on_death()
			else:
				body.on_death()
		else:
			body.on_death()
