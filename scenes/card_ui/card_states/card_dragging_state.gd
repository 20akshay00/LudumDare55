extends CardState

@export var DRAG_MINIMUM_TRESHOLD := 0.05
var minimum_drag_time_elapsed := false

func enter() -> void:
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		card_ui.reparent(ui_layer)
	
	card_ui.state.text = "DRAGGING"
	card_ui.sprite.self_modulate.a = 0.5
	card_ui.slot.remove_card()
	
	minimum_drag_time_elapsed = false
	var threshold_timer := get_tree().create_timer(DRAG_MINIMUM_TRESHOLD, false)
	threshold_timer.timeout.connect(func(): minimum_drag_time_elapsed = true)
	
	
func on_input(event: InputEvent) -> void:
	var mouse_motion := event is InputEventMouseMotion
	var cancel = event.is_action_pressed("right_mouse")
	var confirm = event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse")
	
	if mouse_motion:		
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset
	
	if cancel: 
		card_ui.slot.add_card()
		card_ui.queue_free()
		# transition_requested.emit(self, CardState.State.BASE)
		
	elif minimum_drag_time_elapsed and confirm: 
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)
