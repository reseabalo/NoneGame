extends Control
class_name  MenuOpciones

const guardado_momento: String = "user://GuardadoMomento.json"

#vuelve invisible los botones del menu de pausa
func _on_reanudar_pressed() -> void:
	get_tree().paused = false
	GUI._cambio_visibilidad()

#va al menu de opciones y invisibiliza de menu de pausa
func _on_opciones_pressed() -> void:
	ManejoEscenas.set_nombre_puerta("")
	ManejoEscenas.set_salio_menu(true)
	get_tree().call_group("Jugador","no_permitir_movimiento")
	get_tree().call_group("eventos_juego","cargar_nivel_async","res://Escenas/GUI/Menu Opciones.tscn")
	get_tree().call_group("cargar_juego","guardado_del_momento",guardado_momento)
	GUI._cambio_visibilidad()
	
#vuelve al menu de inicio
#ahora mismos cierra el juego (temporal)
func _on_salir_pressed() -> void:
	get_tree().quit()
