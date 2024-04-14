extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.game_over.connect(_on_game_over)
	
func _on_game_over(): 
	TransitionManager.reload_scene()
	
