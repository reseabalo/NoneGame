extends Node2D

func _on_inicio_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file","res://Escenas/Niveles/Buffet.tscn")

func _on_salir_pressed() -> void:
	get_tree().quit()
