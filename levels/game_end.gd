extends Node

@export var start_screen: PackedScene

func _on_button_pressed() -> void:
	TransitionManager.change_scene(start_screen)
