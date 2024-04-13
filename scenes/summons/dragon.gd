extends CharacterBody2D

@export var summon_name: String = "dragon"
@export var slot: Slot
var direction := Vector2(1, 0)
@onready var sprite := $Sprite2D

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
			if event.is_action_pressed("left_mouse"):
				direction = direction.rotated(PI/2)
				rotation = direction.angle()
				sprite.flip_v = (direction.x == -1)
				
			elif event.is_action_pressed("right_mouse"):
				slot.add_card()
				queue_free()
