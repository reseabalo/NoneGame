extends Node2D
class_name Puerta

@onready var spawn: Marker2D = $Spawn
@onready var interaccion: Area2D = $Interaccion

@export var nombre_puerta_salir: String
@export var direccion_nivel: String
@export var tipo_transicion: String

func _ready() -> void:
	interaccion.interaccion = _en_interaccion

func  _en_interaccion():
	ManejoEscenas.transicion(tipo_transicion)
	ManejoEscenas.set_nombre_puerta(nombre_puerta_salir)
	get_tree().call_group("eventos_juego","cargar_nivel_async",direccion_nivel)

func puerta_a_salir(nombre_puerta_salida: String, jugador : Jugador):	
	if name == nombre_puerta_salida:
		jugador.global_position = spawn.global_position
		ManejoEscenas.terminar_transicion()
