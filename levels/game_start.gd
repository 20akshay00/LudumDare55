extends Node

@export var first_level: String
var tween: Tween = null

func _ready() -> void:
	AudioManager.play_music_level()
	$CreditsPopup.process_mode = Node.PROCESS_MODE_DISABLED
	
func _on_credits_button_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("left_mouse"):
		$StartButton.process_mode = Node.PROCESS_MODE_DISABLED
		$CreditsButton.process_mode = Node.PROCESS_MODE_DISABLED
		
		if tween: tween.kill()
		tween = get_tree().create_tween()
		tween.tween_property($CreditsPopup, "modulate:a", 1., 0.25).set_ease(Tween.EASE_IN)
		tween.tween_callback(func(): $CreditsPopup.process_mode = Node.PROCESS_MODE_INHERIT)
		#$CreditsPopup.visible = true

func _on_close_button_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("left_mouse"):
		#$CreditsPopup.visible = false
		$StartButton.process_mode = Node.PROCESS_MODE_INHERIT
		$CreditsButton.process_mode = Node.PROCESS_MODE_INHERIT

		if tween: tween.kill()
		tween = get_tree().create_tween()
		tween.tween_property($CreditsPopup, "modulate:a", 0., 0.25).set_ease(Tween.EASE_OUT)
		tween.tween_callback(func(): $CreditsPopup.process_mode = Node.PROCESS_MODE_DISABLED)

func _on_start_button_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("left_mouse"):
		LevelManager.load_level(first_level)

