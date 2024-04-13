class_name Hand
extends CanvasLayer

func _ready() -> void:
	for slot in get_children():
		var card_ui := slot.get_children()[0] as CardUI
		card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
		
func _on_card_ui_reparent_requested(card: CardUI) -> void:
	card.reparent(card.slot)
