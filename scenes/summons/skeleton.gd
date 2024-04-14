extends CharacterBody2D

@export var summon_name: String = "skeleton"
@export var slot: Slot
var direction := Vector2(1, 0)
@onready var sprite := $Sprite2D
@onready var arrow := $Arrow

func _ready() -> void:
	arrow.rotation = direction.angle() - PI/2
					
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
			if event.is_action_pressed("left_mouse"):
				direction = direction.rotated(PI/2)
				arrow.rotation = direction.angle() - PI/2
				#sprite.flip_v = (direction.x == -1)
				
			elif event.is_action_pressed("right_mouse"):
				Events.token_removed.emit(global_position)
				slot.add_card()
				queue_free()

func on_death() -> void:
	$Arrow.visible = false
	$CollisionShape2D.queue_free()
	$GPUParticles2D.emitting = true
	
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(sprite, "modulate:a", 0., 0.3)
	tween.parallel().tween_property($GPUParticles2D, "modulate:a", 0., 0.7)	
	tween.tween_callback(queue_free)
		
	Events.token_removed.emit(global_position)


