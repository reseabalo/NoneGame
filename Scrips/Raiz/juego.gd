extends Node2D

@onready var guardado_cargado_partida: Node = %GuardadoCargadoPartida
@onready var raiz_mundo: RaizMundo = %RaizMundo

func _ready() -> void:
	GUI.visibilidad = true
	if ManejoEscenas.get_carga_partida():
		guardado_cargado_partida.cargar_partida()

func _on_button_pressed() -> void:
	guardado_cargado_partida.guardar_partida()


func _on_button_2_pressed() -> void:
	await raiz_mundo.cargar_nivel_async("res://Escenas/Niveles/sotano.tscn")
	#guardado_cargado_partida.cargar_partida()
