extends Line2D

var tween: Tween = null

func create(pos1: Vector2, pos2: Vector2) -> void:
	add_point(pos1)
	add_point(pos1)
		
	tween = get_tree().create_tween()	
	tween.tween_method(update_web_end, pos1, pos2, 1)
			
func remove(pos: Vector2) -> void:
	if tween: tween.kill()
	
	tween = get_tree().create_tween()	
	if pos == get_point_position(0):
		tween.tween_method(update_web_start, get_point_position(0),  get_point_position(1), 1)
	else: 
		tween.tween_method(update_web_end, get_point_position(1),  get_point_position(0), 1)
	tween.tween_callback(queue_free)
			
func update_web_start(new_pos) -> void:
	set_point_position(0, new_pos)
	
func update_web_end(new_pos) -> void:
	set_point_position(1, new_pos)
