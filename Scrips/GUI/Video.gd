extends Control

@onready var resoluciones: OptionButton = $CanvasLayer/GridContainer/Resoluciones
@onready var pantalla_completa: CheckButton = $CanvasLayer/GridContainer/PantallaCompleta

var opciones

func _ready() -> void:
	opciones = GUI.leer_opciones()
	if opciones.has("pantalla_completa"):
		pantalla_completa.set_pressed_no_signal(opciones.pantalla_completa)
	resoluciones.clear()
	var screen_size = DisplayServer.screen_get_size()
	var index = 0
	for tamaño in GUI.resoluciones_lista:
		# display only sizes that fit the current screen size
		if tamaño.ancho <= screen_size.x and tamaño.alto <= screen_size.y:
			resoluciones.add_item(str(tamaño.ancho) + " x " + str(tamaño.alto))
			if opciones.has("window_ancho") and tamaño.ancho == opciones.window_ancho \
				and opciones.has("window_alto") and tamaño.alto == opciones.window_alto:
				resoluciones.select(index)
			index += 1
	GUI.visibilidad = false

#muestra todas la resoluciones que pueden ser seleccionadas dependiendo de tu monitor
func _on_resoluciones_item_selected(index: int) -> void:
	var tamaño = GUI.resoluciones_lista[index]
	opciones.window_ancho = tamaño.ancho
	opciones.window_alto = tamaño.alto
	GUI.escribir_opciones(opciones)
	GUI.redimencionar_ventana()

#se encarga de poner la resolucion de la pantalla en completa
func _on_pantalla_completa_toggled(toggled_on: bool) -> void:
	opciones.pantalla_completa = toggled_on
	GUI.escribir_opciones(opciones)
	GUI.set_modo_pantalla()
	GUI.redimencionar_ventana()

func _on_volver_pressed() -> void:
	if ManejoEscenas.esta_juego:
		get_tree().call_group("eventos_juego","cargar_nivel_async","res://Escenas/GUI/Menu Opciones.tscn")
	else:
		get_tree().change_scene_to_file("res://Escenas/GUI/Menu Opciones.tscn")
