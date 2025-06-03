extends Node

var _escena_pantalla_carga: PackedScene = preload("res://Escenas/ManejoEscenas/pantalla_carga.tscn")
var _pantalla_carga: LoadingScreen
var _transicion: String
var nombre_puerta_salir: String
var _escena_simultania: Node
var dato: int = 0 #temporal para la vida del jugador

signal trigger_en_el_spawn_jugador
signal escena_cambio


func ir_a_nivel(nivel_direccion: String, nombre_puerta: String , tipo_transicion: String):
	_escena_simultania = load(nivel_direccion).instantiate()
	if nivel_direccion != null:
		transicion(tipo_transicion)
		nombre_puerta_salir = nombre_puerta
		change_scene_to_node(_escena_simultania)
		#get_tree().call_deferred("change_scene_to_file",nivel_direccion)		
		call_deferred("_emitir_señal")
		

func posicion_en_spawn(posicion: Vector2, direccion: String):
	trigger_en_el_spawn_jugador.emit(posicion,direccion)

func transicion(tipo_transicion: String):
	
	_transicion = "no_ir_transicion" if tipo_transicion == "no_transicion" else tipo_transicion
	_pantalla_carga = _escena_pantalla_carga.instantiate() as LoadingScreen
	get_tree().root.add_child(_pantalla_carga)
	_pantalla_carga.start_transition(_transicion)
	
	if _pantalla_carga != null:
		_pantalla_carga.finish_transition()
		
func change_scene_to_node(node):
	var tree = get_tree()
	var cur_scene = tree.get_current_scene()
	tree.get_root().call_deferred("add_child",node) 
	tree.get_root().call_deferred("remove_child",cur_scene)
	tree.call_deferred("set_current_scene",node) 

func _emitir_señal():
	escena_cambio.emit(get_dato())
	
func set_dato(new_dato):
	dato = new_dato
	
func get_dato():
	return dato
