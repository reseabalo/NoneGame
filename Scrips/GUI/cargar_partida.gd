extends Node2D

func _on_texture_button_pressed() -> void:
	ManejoEscenas.set_carga_partida()
	ManejoEscenas.transicion("ir_negro")
	get_tree().change_scene_to_file("res://Escenas/Raiz/Juego.tscn")
