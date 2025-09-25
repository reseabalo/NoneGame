extends Node2D

@onready var musica_menu: AudioStreamPlayer = $"Musica Menu"

#se encarga se settear los cambios que hallas hecho en el menu de opciones
func _ready() -> void:
	GUI.calculate_window_size()
	GUI.set_modo_pantalla()
	GUI.redimencionar_ventana()
	GUI.visibilidad = false

		
#inicia en la escena del comienzo del juego
func _on_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/GUI/seleccion_personaje.tscn")

func _on_cargar_partida_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/GUI/cargar_Partida.tscn")

#va a la escena del menu de obciones
func _on_opciones_pressed() -> void:
	ManejoEscenas.ir_a_escena("res://Escenas/GUI/Menu Opciones.tscn","ir_oscurecer","res://Escenas/ManejoEscenas/pantalla_inico.tscn")

#salir del juego
func _on_salir_pressed() -> void:
	get_tree().quit()
