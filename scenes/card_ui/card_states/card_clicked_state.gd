extends CardState

@onready var sound_pickup = preload("res://assets/audio/LD55 Card Pickup.wav")

func enter() -> void:
	card_ui.state.text = "CLICKED"
	card_ui.drop_point_detector.monitoring = true
	
func on_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		AudioManager.play_effect(sound_pickup, -5)
		transition_requested.emit(self, CardState.State.DRAGGING)
		
