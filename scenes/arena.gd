extends TileMap

@export var _gridsize = Vector2(13, 13)
var grid = {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in _gridsize.x:
		for y in _gridsize.y:
			var cell_type = get_cell_source_id(0, Vector2i(x, y))
			grid[Vector2i(x, y)] = {
				"can_place": not bool(cell_type),
				"object": null, 
			}
			
	self_modulate.a = 0

func set_occupied(tile: Vector2i, object: Node) -> void:
	grid[tile]["object"] = object

func is_valid_placement(tile: Vector2i) -> bool:
	if is_cell_out_of_bounds(tile):
		return false
	return grid[tile]["can_place"] and (grid[tile]["object"] == null)
		
func is_cell_out_of_bounds(tile: Vector2i) -> bool:
	return not get_cell_tile_data(0, tile)
		
#func _process(delta: float) -> void:
	#var tile = local_to_map(get_local_mouse_position())

	#for x in _gridsize:
		#for y in _gridsize:
			#erase_cell(1, Vector2i(x, y))
			#
	#if grid.has(tile):
		#set_cell(1, tile, 2 + int(not grid[tile]["can_place"]), Vector2i(0, 0))
#
