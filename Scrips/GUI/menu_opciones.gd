extends Control

const guardado_momento: String = "user://GuardadoMomento.json"

func _ready() -> void:
	GUI.visibilidad = false
	ManejoEscenas.terminar_transicion()

func _on_audio_pressed() -> void:
	if ManejoEscenas.esta_juego:
		get_tree().call_group("eventos_juego","cargar_nivel_async","res://Escenas/GUI/Audio.tscn")
	else:
		get_tree().change_scene_to_file("res://Escenas/GUI/Audio.tscn")


func _on_video_pressed() -> void:
	if ManejoEscenas.esta_juego:
		get_tree().call_group("eventos_juego","cargar_nivel_async","res://Escenas/GUI/Video.tscn")
	else:
		get_tree().change_scene_to_file("res://Escenas/GUI/Video.tscn")


func _on_controles_pressed() -> void:
	if ManejoEscenas.esta_juego:
		get_tree().call_group("eventos_juego","cargar_nivel_async","res://Escenas/GUI/controles.tscn")
	else:
		get_tree().change_scene_to_file("res://Escenas/GUI/controles.tscn")


func _on_volver_pressed() -> void:
	if ManejoEscenas.esta_juego:
		get_tree().call_group("cargar_juego","cargardo_del_momento",guardado_momento)
		get_tree().call_group("Jugador","permitir_movimiento")
		GUI.visibilidad = true
	else:
		get_tree().change_scene_to_file("res://Escenas/ManejoEscenas/pantalla_inico.tscn")
