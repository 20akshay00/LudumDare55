extends Node

@export var start_screen: PackedScene

func _on_button_pressed() -> void:
	LevelManager.load_level("start")
