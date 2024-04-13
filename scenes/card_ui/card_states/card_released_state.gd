extends CardState

var played: bool

func enter() -> void:
	card_ui.state.text = "RELEASED"
	played = false
	if not card_ui.targets.is_empty():
		played = true

func on_input(_event: InputEvent) -> void:
	if played:
		card_ui.play()
		return
	
	card_ui.slot.add_card()
	card_ui.queue_free()		
	#transition_requested.emit(self, CardState.State.BASE)
