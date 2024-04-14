extends CharacterBody2D

@onready var arena: TileMap = get_parent()
@export var SPEED: float = 2

func _ready() -> void:
	pass # Replace with function body.
	
func _process(delta: float) -> void:
	var collision = move_and_collide(velocity)
	if collision:
		var body = collision.get_collider()
		if "summon_name" in body:
			if body.summon_name == "skeleton":
				var cur_dir = velocity.normalized()
				if cur_dir == body.direction:
					body.on_death()
				elif cur_dir == -body.direction:
					queue_free()
				else:
					velocity = SPEED * body.direction
		else:
			queue_free()

func launch(dir: Vector2) -> void:
	velocity = SPEED * dir
