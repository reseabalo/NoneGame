extends Control

@onready var slider_volumen_general: HSlider = $CanvasLayer/ContenedorAudio/SliderVolumenGeneral
@onready var slider_musica: HSlider = $CanvasLayer/ContenedorAudio/SliderMusica
@onready var slider_efectos_sonido: HSlider = $CanvasLayer/ContenedorAudio/SliderEfectosSonido

var opciones

func _ready() -> void:
	opciones = GUI.leer_opciones()
	slider_volumen_general.value = opciones.master_volume if opciones.has("master_volume") else 1.0
	slider_musica.value = opciones.musica_volume if opciones.has("musica_volume") else 1.0
	slider_efectos_sonido.value = opciones.sfx_volume if opciones.has("sfx_volume") else 1.0



func _on_slider_volumen_general_value_changed(value) -> void:
	opciones.master_volume = value
	GUI.escribir_opciones(opciones)
	ManejoSonidos.set_master_volumen(value)

func _on_slider_musica_value_changed(value) -> void:
	opciones.musica_volume = value
	GUI.escribir_opciones(opciones)
	ManejoSonidos.set_musica_volumen(value)

func _on_slider_efectos_sonido_value_changed(value) -> void:
	opciones.sfx_volume = value
	GUI.escribir_opciones(opciones)
	ManejoSonidos.set_sfx_volumen(value)

func _on_volver_pressed() -> void:
	if ManejoEscenas.esta_juego:
		get_tree().call_group("eventos_juego","cargar_nivel_async","res://Escenas/GUI/Menu Opciones.tscn")
	else:
		get_tree().change_scene_to_file("res://Escenas/GUI/Menu Opciones.tscn")
