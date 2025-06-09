extends Node2D


#se encarga se settear los cambios que hallas hecho en el menu de opciones
func _ready() -> void:
	GUI.calculate_window_size()
	GUI.set_modo_pantalla()
	GUI.redimencionar_ventana()
	GUI.visibilidad = false

#inicia en la escena del comienzo del juego
func _on_jugar_pressed() -> void:
	ManejoEscenas.ir_a_nivel("res://Escenas/Niveles/Buffet.tscn","","ir_oscurecer")

#va a la escena del menu de obciones
func _on_opciones_pressed() -> void:
	ManejoEscenas.ir_a_escena("res://Escenas/GUI/menu_opciones.tscn","ir_oscurecer","res://Escenas/ManejoEscenas/pantalla_inico.tscn")

#salir del juego
func _on_salir_pressed() -> void:
	get_tree().quit()
