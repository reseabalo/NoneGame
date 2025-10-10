extends Control


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/GUI/Menu Opciones.tscn")


func _on_restaurar_valores_predeterminados_pressed() -> void:
	ManejoTeclas.reset_keymap()
	# resetea UI
	for item in Utils.get_all_children($CanvasLayer/ContenedorControles):
		if item is ManejoTeclas:
			item.display_current_key()
	get_tree().reload_current_scene()
