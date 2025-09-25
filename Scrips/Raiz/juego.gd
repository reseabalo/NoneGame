extends Node2D

@onready var guardado_cargado_partida: Node = %GuardadoCargadoPartida

func _ready() -> void:
	GUI.visibilidad = true
	if ManejoEscenas.get_carga_partida():
		guardado_cargado_partida.cargar_partida()

func _on_button_pressed() -> void:
	guardado_cargado_partida.guardar_partida()


func _on_button_2_pressed() -> void:
	guardado_cargado_partida.cargar_partida()
