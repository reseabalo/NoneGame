extends Node

var _escena_pantalla_carga: PackedScene = preload("res://Escenas/ManejoEscenas/pantalla_carga.tscn")
var _pantalla_carga: LoadingScreen
var _transicion: String
var nombre_puerta_salir: String
var escena_actual: String = "res://Escenas/Niveles/buffet.tscn"

var _personaje_1: bool
var _personaje_2: bool

var carga_partida: bool
var esta_juego: bool = false
var salio_de_menu: bool = false
var reproducir_cinematica_inicio: bool = true

var nombre_puerta_salida:String
var nombre_ultima_puerta: String = ""

func transicion(tipo_transicion: String):
	
	_transicion = "no_ir_transicion" if tipo_transicion == "no_transicion" else tipo_transicion
	_pantalla_carga = _escena_pantalla_carga.instantiate() as LoadingScreen
	get_tree().root.add_child(_pantalla_carga)
	_pantalla_carga.start_transition(_transicion)
	
func terminar_transicion():
	if _pantalla_carga != null:
		_pantalla_carga.finish_transition()

	
func get_carga_partida():
	return carga_partida

func set_nombre_puerta(nuevo_nombre_puerta: String):
	nombre_puerta_salida = nuevo_nombre_puerta

func get_nombre_puerta():
	return nombre_puerta_salida

func set_seleccionar_personaje(perso_1:bool, perso_2: bool):
	_personaje_1 = perso_1
	_personaje_2 = perso_2

func get_seleccionar_personaje():
	return [_personaje_1,_personaje_2]
	
func set_escena_actual(nueva_escena_actual: String):
	escena_actual = nueva_escena_actual

func  get_escena_actual():
	return escena_actual

func set_salio_menu(new_salio_menu: bool):
	salio_de_menu = new_salio_menu

func get_salio_menu():
	return salio_de_menu

func set_nombre_ultima_puerta(nuevo_nombre: String):
	nombre_ultima_puerta = nuevo_nombre

func get_nombre_ultima_puerta():
	return nombre_ultima_puerta
