class_name Hand
extends CanvasLayer

func _ready() -> void:
	pass
	
func _on_card_ui_reparent_requested(card: CardUI) -> void:
	card.reparent(card.slot)
