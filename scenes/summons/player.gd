class_name Player
extends CharacterBody2D

const SPEED = 300.0

func _process(delta: float) -> void:
	var dir = Input.get_vector("left", "right", "up", "down")
	velocity = SPEED * dir
	move_and_slide()
	pass
