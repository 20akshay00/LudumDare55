extends Node

func _ready() -> void:
	Events.game_over.connect(_on_game_over)
	
func _on_game_over(): 
	TransitionManager.reload_scene()
	
func _on_help_button_pressed() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	$HelpPopup.show()
	var tween = get_tree().create_tween()
	tween.tween_property($HelpPopup, "modulate:a", 1, 0.25)

func resume() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	var tween = get_tree().create_tween()
	tween.tween_property($HelpPopup, "modulate:a", 0, 0.25)
	tween.tween_callback($HelpPopup.hide)
