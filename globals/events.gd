extends Node

signal card_played(pos: Vector2, creature: PackedScene)
signal token_removed(pos: Vector2)
signal game_over
signal web_created(pos1: Vector2, pos2: Vector2i)
signal web_removed(pos1: Vector2, pos2: Vector2i)
signal web_anim_complete
signal wall_broken(pos: Vector2)
