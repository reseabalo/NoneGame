extends Control


func _on_audio_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/GUI/Audio.tscn")


func _on_video_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/GUI/Video.tscn")


func _on_controles_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/GUI/controles.tscn")


func _on_volver_pressed() -> void:
	ManejoEscenas.salir_menu_opciones(ManejoEscenas.ultima_escena_ejecutada,"ir_oscurecer")
