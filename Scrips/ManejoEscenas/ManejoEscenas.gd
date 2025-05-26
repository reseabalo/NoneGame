extends Node

var nombre_puerta_salir: String

var _escena_pantalla_carga: PackedScene = preload("res://Escenas/ManejoEscenas/pantalla_carga.tscn")
var _pantalla_carga: LoadingScreen
var _transicion: String

signal trigger_en_el_spawn_jugador

func ir_a_nivel(nivel_direccion: String, nombre_puerta: String , tipo_transicion: String):
	
	if nivel_direccion != null:
		_agregar_pantalla_carga(tipo_transicion)
		nombre_puerta_salir = nombre_puerta
		get_tree().call_deferred("change_scene_to_file",nivel_direccion)
		

func posicion_en_spawn(posicion: Vector2, direccion: String):
	trigger_en_el_spawn_jugador.emit(posicion,direccion)


func _agregar_pantalla_carga(tipo_transicion: String = "ir_oscurecer"):
	
	_transicion = "no_ir_transicion" if tipo_transicion == "no_transicion" else tipo_transicion
	_pantalla_carga = _escena_pantalla_carga.instantiate() as LoadingScreen
	get_tree().root.add_child(_pantalla_carga)
	_pantalla_carga.start_transition(_transicion)
	
	if _pantalla_carga != null:
		_pantalla_carga.finish_transition()
