class_name Slot
extends Control

@export var summon_name: String = "dragon"
@export var card_scene: PackedScene
@export var quantity := 1

func _ready() -> void:
	card_scene = preload("res://scenes/card_ui/card_ui.tscn")
	if quantity > 0: 
		var card = card_scene.instantiate()
		add_child(card)
		card.slot = self
		card.sprite.texture = load("res://assets/art/cards/{a}.png".format({"a": summon_name}))
		card.creature_scene = load("res://scenes/summons/{a}.tscn".format({"a": summon_name}))
		
