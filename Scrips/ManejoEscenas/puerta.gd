extends Node2D
class_name Puerta

signal entro_puerta

@onready var spawn: Marker2D = $Spawn
@onready var interaccion: Area2D = $Interaccion

@export var nombre_puerta_salir: Array[String]
@export var direccion_nivel: String
@export var tipo_transicion: String

func _ready() -> void:
	interaccion.interaccion = _en_interaccion

func  _en_interaccion():
	var ciclo : bool = true
	var cont : int = 0
	
	if nombre_puerta_salir.size() < 2:
		ManejoEscenas.set_nombre_ultima_puerta(name)
		ManejoEscenas.set_nombre_puerta(nombre_puerta_salir[0])
		ciclo = false
	
	while ciclo:
		if ManejoEscenas.get_nombre_ultima_puerta() == nombre_puerta_salir[cont]:
			ManejoEscenas.set_nombre_puerta(nombre_puerta_salir[cont])
			ciclo = false
		elif ManejoEscenas.get_nombre_ultima_puerta() == "":
			ManejoEscenas.set_nombre_ultima_puerta(name)
		else:
			cont += 1
	
	ManejoEscenas.transicion(tipo_transicion)
	get_tree().call_group("eventos_juego","cargar_nivel_async",direccion_nivel)
	entro_puerta.emit()
	

func puerta_a_salir(nombre_puerta_salida: String, jugador : Jugador):
	
	if name == nombre_puerta_salida:
		jugador.global_position = spawn.global_position
		ManejoEscenas.terminar_transicion()
