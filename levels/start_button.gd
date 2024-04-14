extends Area2D
@export var first_level: PackedScene

func _ready() -> void:
	AudioManager.play_music_level()
		
func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("left_mouse"):
			TransitionManager.change_scene(first_level)
