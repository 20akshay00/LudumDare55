class_name CardUI
extends Control

signal reparent_requested(which_card_ui: CardUI)

@onready var drop_point_detector = $DropPointDetector
@onready var state = $State
@onready var state_machine: CardStateMachine = $CardStateMachine as CardStateMachine

func _ready() -> void:
	state_machine.init(self)
	
func _input(event: InputEvent) -> void:
	state_machine.on_input(event)
	
func _on_gui_input(event: InputEvent) -> void:
	state_machine.on_gui_input(event)
	
func _on_mouse_entered() -> void:
	state_machine.on_mouse_entered()

func _on_mouse_exited() -> void:
	state_machine.on_mouse_exited()
