extends Node2D

@onready var guardado_cargado_partida: Node = %GuardadoCargadoPartida
@onready var raiz_mundo: RaizMundo = %RaizMundo

func _ready() -> void:
	ManejoEscenas.esta_juego = true
	GUI.visibilidad = true
	if ManejoEscenas.get_carga_partida():
		guardado_cargado_partida.cargar_partida()


func _on_a_pausa_pressed() -> void:
	GUI._cambio_visibilidad()
	get_tree().paused = true
	
