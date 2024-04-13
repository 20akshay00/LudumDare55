class_name Slot
extends Control

@export var summon_name: String = "dragon"
@export var card_scene: PackedScene
@onready var label := $QuantityLabel
var quantity := 3 : 
	set (value):
		quantity = value
		if quantity > 0:
			label.text = str(quantity)	
		else:
			label.text = str("")
	get: 
		return quantity

func _ready() -> void:
	card_scene = preload("res://scenes/card_ui/card_ui.tscn")
	label.text = str(quantity)
	label.add_theme_font_size_override("font_size", 30)
	label.position = Vector2(0, 0)
	
	if quantity > 0: update()
	
func add_card() -> void:
	update()
	quantity += 1
	
func remove_card() -> void:
	if quantity > 0:
		quantity -= 1
		update()
	
func update() -> void:
	if len(get_children()) == 1 and quantity > 0:
		var card = card_scene.instantiate()
		add_child(card)
		card.slot = self
		card.sprite.texture = load("res://assets/art/cards/{a}.png".format({"a": summon_name}))
		card.creature_scene = load("res://scenes/summons/{a}.tscn".format({"a": summon_name}))
		
