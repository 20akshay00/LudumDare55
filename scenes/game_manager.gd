extends Node

@export var arena: TileMap
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.card_played.connect(_on_card_played)
	
func _on_card_played(pos: Vector2, creature_scene: PackedScene, slot: Slot):
	var creature = creature_scene.instantiate()
	var tile = arena.local_to_map(arena.to_local(pos))
	if arena.is_valid_placement(tile):
		arena.add_child(creature)
		creature.position = arena.map_to_local(tile)
		creature.slot = slot
		arena.set_occupied(tile, creature)
	else: 
		slot.add_card()
	
