extends CharacterBody2D

@export var summon_name: String = "spider"
@export var slot: Slot
@export var web_scene: PackedScene

@onready var sprite := $Sprite2D
@onready var arrow := $Arrow
@onready var sound_fx = preload("res://assets/audio/LD55 Spider.wav")

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
				
			#elif event.is_action_pressed("right_mouse"):
				#update_web()
				#Events.token_removed.emit(get_global_mouse_position())
				#slot.add_card()
				#queue_free()

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
	if web and is_instance_valid(web):
		Events.web_removed.emit(position, partner.position) 
		web.remove(position)
		partner.web = null
		partner.partner = null
		web = null		
		partner = null
		
	partner = look_for_partner()
	
	if partner:
		if partner.direction.dot(direction) == -1: 
			Events.web_created.emit(position, partner.position) 
			web = web_scene.instantiate()
			add_sibling(web)
			get_parent().move_child(web, 0)
			web.create(position, partner.position)
			AudioManager.play_effect(sound_fx, -5)
				
			partner.partner = self
			partner.web = web
		
