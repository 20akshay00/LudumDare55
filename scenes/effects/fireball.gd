extends CharacterBody2D

@onready var arena: TileMap = get_parent()
@export var SPEED: float = 2

func _ready() -> void:
	pass # Replace with function body.
	
func _process(_delta: float) -> void:
	var collision = move_and_collide(velocity)
	if collision:
		var body = collision.get_collider()
		if "summon_name" in body:
			if body.summon_name == "skeleton":
				var cur_dir = velocity.normalized()
				print(cur_dir.dot(body.direction))
				if cur_dir.dot(body.direction) == 1:
					body.on_death()
				elif cur_dir.dot(body.direction) == -1:
					on_death()
				else:
					velocity = SPEED * body.direction
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
	
