extends Control
class_name  MenuOpciones

#vuelve invisible los botones del menu de pausa
func _on_reanudar_pressed() -> void:
	GUI._cambio_visibilidad()

#va al menu de opciones y invisibiliza de menu de pausa
func _on_opciones_pressed() -> void:
	ManejoEscenas.ir_a_escena("res://Escenas/GUI/menu_opciones.tscn","ir_oscurecer","")
	GUI._cambio_visibilidad()

#vuelve al menu de inicio
func _on_salir_pressed() -> void:
	ManejoEscenas.ir_a_escena("res://Escenas/ManejoEscenas/pantalla_inico.tscn","ir_oscurecer","")
	GUI._cambio_visibilidad()
