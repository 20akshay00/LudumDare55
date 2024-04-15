extends Control

@export_multiline var text: String = ""
func _ready() -> void:
	z_index = 5
	$Label.text = text
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _on_texture_button_pressed() -> void:
	get_parent().resume()
