extends Node

@export var arena: TileMap
@onready var sound_place = preload("res://assets/audio/LD55 Card Place.wav")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.card_played.connect(_on_card_played)
	Events.token_removed.connect(_on_token_removed)
	
func _on_card_played(pos: Vector2, creature_scene: PackedScene, slot: Slot):
	var creature = creature_scene.instantiate()
	var tile = arena.local_to_map(arena.to_local(pos))
	if arena.is_valid_placement(tile):
		AudioManager.play_effect(sound_place, -2)
		arena.add_child(creature)
		creature.position = arena.map_to_local(tile)
		creature.slot = slot
		arena.set_occupied(tile, creature)
	else: 
		slot.add_card()
	
func _on_token_removed(pos: Vector2):
	var tile = arena.local_to_map(arena.to_local(pos))
	arena.grid[tile]["object"] = null
