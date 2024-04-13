class_name CardUI
extends Control

signal reparent_requested(which_card_ui: CardUI)

@onready var drop_point_detector = $DropPointDetector
@onready var state = $State
@onready var state_machine: CardStateMachine = $CardStateMachine as CardStateMachine
@onready var targets: Array[Node] = []
@onready var sprite := $Sprite2D

@export var creature_scene: PackedScene
@export var slot: Control

@onready var cursor_default = load("res://assets/art/cursor/default.png")
@onready var cursor_grab = load("res://assets/art/cursor/grab.png")
@onready var cursor_open = load("res://assets/art/cursor/open.png")

func _ready() -> void:
	state_machine.init(self)
	
func _input(event: InputEvent) -> void:
	state_machine.on_input(event)
	
func _on_gui_input(event: InputEvent) -> void:
	state_machine.on_gui_input(event)
	
func _on_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(cursor_open)
	if Input.is_action_pressed("left_mouse"):
		Input.set_custom_mouse_cursor(cursor_grab)
	state_machine.on_mouse_entered()

func _on_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(cursor_default)
	state_machine.on_mouse_exited()

func _on_drop_point_detector_body_entered(body: Node2D) -> void:
	if not targets.has(body):
		targets.append(body)

func _on_drop_point_detector_body_exited(body: Node2D) -> void:
	targets.erase(body)
	
func play() -> void:
	Events.card_played.emit(get_global_mouse_position(), creature_scene, slot)
	queue_free()

