extends TileMap

@export var _gridsize = Vector2(5, 5)
var grid = {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#for x in _gridsize.x:
		#for y in _gridsize.y:
			#var cell_type = randi() % 2
			#set_cell(0, Vector2i(x, y), cell_type, Vector2i(0, 0))
			#grid[Vector2i(x, y)] = {
				#"can_place": not bool(cell_type),
				#"object": null, 
			#}
	self_modulate.a = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var tile = local_to_map(get_local_mouse_position())

	#for x in _gridsize:
		#for y in _gridsize:
			#erase_cell(1, Vector2i(x, y))
			#
	#if grid.has(tile):
		#set_cell(1, tile, 2 + int(not grid[tile]["can_place"]), Vector2i(0, 0))
#
