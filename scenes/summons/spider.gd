extends CharacterBody2D

@export var summon_name: String = "spider"
@export var slot: Slot
var direction := Vector2(1, 0)
@onready var sprite := $Sprite2D
@onready var arrow := $Arrow

func _ready() -> void:
	arrow.rotation = direction.angle() - PI/2
					
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
			if event.is_action_pressed("left_mouse"):
				direction = direction.rotated(PI/2)
				arrow.rotation = direction.angle() - PI/2
				#sprite.flip_v = (direction.x == -1)
				
			elif event.is_action_pressed("right_mouse"):
				Events.token_removed.emit(get_global_mouse_position())
				slot.add_card()
				queue_free()
