extends CharacterBody2D

@export var summon_name: String = "dragon"
@export var slot: Slot
@export var fireball_scene: PackedScene

var direction := Vector2(-1, 0)
@onready var sprite := $Sprite2D
@onready var arrow := $Arrow
@onready var timer := $ShootTimer
@onready var sound_fx = preload("res://assets/audio/LD55 Dragon Fire_.wav")

var frozen = false

func _ready() -> void:
	arrow.rotation = direction.angle() - PI/2
	timer.timeout.connect(shoot)
					
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
			if event.is_action_pressed("left_mouse"):
				direction = direction.rotated(PI/2)
				arrow.rotation = direction.angle() - PI/2
				#sprite.flip_v = (direction.x == -1)
				
			#elif event.is_action_pressed("right_mouse"):
				#Events.token_removed.emit(get_global_mouse_position())
				#slot.add_card()
				#queue_free()

func unfreeze() -> void:
	timer.start()

func shoot() -> void:
	var fireball = fireball_scene.instantiate()
	add_sibling(fireball)
	fireball.position = position + (5 + get_parent().tile_set.tile_size.x) * direction
	fireball.launch(direction)
	AudioManager.play_effect(sound_fx, -5)
	
func on_death() -> void:
	$Arrow.visible = false
	$CollisionShape2D.queue_free()
	$GPUParticles2D.emitting = true
	
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(sprite, "modulate:a", 0., 0.3)
	tween.parallel().tween_property($GPUParticles2D, "modulate:a", 0., 0.7)	
	tween.tween_callback(queue_free)
		
	Events.token_removed.emit(global_position)
	
