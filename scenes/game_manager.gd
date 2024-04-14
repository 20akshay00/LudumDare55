extends Node

@export var arena: TileMap
@export var player_tile := Vector2i(6, 10)
@export var player_can_move := true

@onready var sound_place = preload("res://assets/audio/LD55 Card Place.wav")
@onready var sound_place_fail = preload("res://assets/audio/LD55 Placement Blocked.wav")

var player_scene = preload("res://scenes/summons/player.tscn")
var player: CharacterBody2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.play_music_level()
	Events.card_played.connect(_on_card_played)
	Events.token_removed.connect(_on_token_removed)
	Events.web_created.connect(_on_web_created)
	Events.web_removed.connect(_on_web_removed)
	Events.web_anim_complete.connect(_on_web_anim_complete)
	
	player = player_scene.instantiate()
	arena.add_child(player)
	player.z_index = 2
	player.position = arena.map_to_local(player_tile)
	
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
		AudioManager.play_effect(sound_place_fail, 3)
		slot.add_card()
	
func _on_token_removed(pos: Vector2):
	var tile = arena.local_to_map(arena.to_local(pos))
	arena.grid[tile]["object"] = null
	
func _input(event: InputEvent) -> void:
	var dir = Vector2(0, 0)
	if Input.is_action_just_pressed("down"):
		dir = Vector2(0, 1)
	elif Input.is_action_just_pressed("up"):
		dir = Vector2(0, -1)
	elif Input.is_action_just_pressed("right"):
		dir = Vector2(1, 0)
	elif Input.is_action_just_pressed("left"):
		dir = Vector2(-1, 0)
		
	if (abs(dir.x) == 1 or abs(dir.y) == 1) and player_can_move:
		#arena.can_player_move()
		arena.set_unoccupied(player_tile)
		var new_tile = player_tile + Vector2i(dir.x, dir.y)

		if arena.is_valid_player_move(new_tile):
			player_tile = new_tile
			arena.set_occupied(player_tile, player)
			
			player_can_move = false
			var tween = get_tree().create_tween()
			tween.tween_property(player, "position", arena.map_to_local(player_tile), 0.5).set_ease(Tween.EASE_IN_OUT)
			if arena.is_chasm_drop(player_tile):
				tween.tween_callback(player.on_fall)
			else:
				tween.tween_callback(func(): player_can_move = true)


func _on_web_created(pos1: Vector2, pos2: Vector2):
	var tile1 = arena.local_to_map(pos1)
	var tile2 = arena.local_to_map(pos2)
	var dir = (tile1 - tile2)
	
	if dir.x == 0:
		var start = min(tile1.y, tile2.y)
		var end = max(tile1.y, tile2.y)
		for y in range(start, end):
			arena.set_web(Vector2i(tile1.x, y))
	elif dir.y == 0:
		var start = min(tile1.x, tile2.x)
		var end = max(tile1.x, tile2.x)
		for x in range(start, end):
			arena.set_web(Vector2i(x, tile1.y))		

func _on_web_removed(pos1: Vector2, pos2: Vector2):
	var tile1 = arena.local_to_map(pos1)
	var tile2 = arena.local_to_map(pos2)
	var dir = (tile1 - tile2)
	
	if dir.x == 0:
		var start = min(tile1.y, tile2.y)
		var end = max(tile1.y, tile2.y)
		for y in range(start, end):
			arena.unset_web(Vector2i(tile1.x, y))
	elif dir.y == 0:
		var start = min(tile1.x, tile2.x)
		var end = max(tile1.x, tile2.x)
		for x in range(start, end):
			arena.unset_web(Vector2i(x, tile1.y))		
	
func _on_web_anim_complete() -> void:	
	if arena.is_chasm_drop(player_tile):
		player.on_fall()
