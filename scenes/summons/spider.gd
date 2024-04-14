extends CharacterBody2D

@export var summon_name: String = "spider"
@export var slot: Slot
@export var web_scene: PackedScene

@onready var sprite := $Sprite2D
@onready var arrow := $Arrow

var direction := Vector2(1, 0)
var partner: CharacterBody2D = null
var web: Line2D = null

func _ready() -> void:
	arrow.rotation = direction.angle() - PI/2
	$RayCast2D.rotation = direction.angle() + PI/2
	update_web()
		
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
			if event.is_action_pressed("left_mouse"):
				direction = direction.rotated(PI/2)
				arrow.rotation = direction.angle() - PI/2
				$RayCast2D.rotation = direction.angle() + PI/2
				update_web()
				
			elif event.is_action_pressed("right_mouse"):
				update_web()
				Events.token_removed.emit(get_global_mouse_position())
				slot.add_card()
				queue_free()

func on_death() -> void:
	update_web()
	
	$Arrow.visible = false
	$CollisionShape2D.queue_free()
	$GPUParticles2D.emitting = true
	
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(sprite, "modulate:a", 0., 0.3)
	tween.parallel().tween_property($GPUParticles2D, "modulate:a", 0., 0.7)	
	tween.tween_callback(queue_free)
		
	Events.token_removed.emit(global_position)

func look_for_partner():
	var body = $RayCast2D.get_collider()
	if body:
		if "summon_name" in body:
			if body.summon_name == "spider":
				return body
			else:
				return null
		else:
			return null
	else:
		return null
	
func update_web() -> void:
	if partner:
		if is_instance_valid(web): 
			web.queue_free()
			
		web = null
		partner.web = null
		partner.partner = null
		partner = null
		
	partner = look_for_partner()
	if partner:
		if partner.direction.dot(direction) == -1: 
			web = web_scene.instantiate()
			web.add_point(position)
			web.add_point(position)
		
			web.tween = get_tree().create_tween()	
			web.tween.tween_method(update_web_end, position, partner.position, 1)
			
			add_sibling(web)
			get_parent().move_child(web, 0)
			
			partner.partner = self
			partner.web = web
		
func update_web_start(new_pos) -> void:
	web.set_point_position(0, new_pos)
	
func update_web_end(new_pos) -> void:
	web.set_point_position(1, new_pos)

