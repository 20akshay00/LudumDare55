extends TileMap

@export var _gridsize = Vector2(13, 13)
var grid = {}
var player_grid = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in _gridsize.x:
		for y in _gridsize.y:
			var cell_type = get_cell_source_id(0, Vector2i(x, y))
			grid[Vector2i(x, y)] = {
				"can_place": not bool(cell_type),
				"object": null, 
			}
			
	for x in _gridsize.x:
		for y in _gridsize.y:
			var cell_type = get_cell_source_id(0, Vector2i(x, y))
			player_grid[Vector2i(x, y)] = {
				"is_wall": cell_type == 1,
				"is_chasm": cell_type == 2,
				"web": false
			}
			
	self_modulate.a = 0

func set_occupied(tile: Vector2i, object: Node) -> void:
	grid[tile]["object"] = object
	
func set_unoccupied(tile: Vector2i) -> void:
	grid[tile]["object"] = null

func is_valid_placement(tile: Vector2i) -> bool:
	if is_cell_out_of_bounds(tile):
		return false
	return grid[tile]["can_place"] and (grid[tile]["object"] == null)
		
func is_cell_out_of_bounds(tile: Vector2i) -> bool:
	return not get_cell_tile_data(0, tile)
		
func is_valid_player_move(tile: Vector2i) -> bool:
	return not player_grid[tile]["is_wall"]
	
func is_chasm_drop(tile: Vector2i) -> bool:
	return player_grid[tile]["is_chasm"] and not player_grid[tile]["web"]
	
func set_web(tile: Vector2i) -> void:
	player_grid[tile]["web"] = true

func unset_web(tile: Vector2i) -> void:
	player_grid[tile]["web"] = false
#func _process(delta: float) -> void:
	#var tile = local_to_map(get_local_mouse_position())

	#for x in _gridsize:
		#for y in _gridsize:
			#erase_cell(1, Vector2i(x, y))
			#
	#if grid.has(tile):
		#set_cell(1, tile, 2 + int(not grid[tile]["can_place"]), Vector2i(0, 0))
#
