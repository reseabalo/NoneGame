extends Node2D
class_name  RaizMundo

@onready var jugador: Jugador = %Jugador
@onready var jugador_2: Jugador = %"Jugador 2"

var lista: Array

func _ready() -> void:
	
	var lista_temp: Array
	lista_temp = ManejoEscenas.get_seleccionar_personaje()
	var con: int = 0
	for lis in lista:
		
		if lis == false:
			con += 1
	
	if con < 2:
		en_seleccion_de_personaje(lista_temp)


func cargar_nivel_async(direccion: String):
	await get_tree().physics_frame
	get_tree().paused = true 
	
	var siguente_nivel = load(direccion).instantiate()
	
	for child in get_children():
		if not child.is_in_group("Raiz_no_tocar"):
			remove_child(child)
			child.queue_free()
	
	add_child(siguente_nivel)
	
	for child in get_children():
		if child.is_in_group("Raiz_no_tocar"):
			child.move_to_front()
	
	get_tree().paused = false

func en_seleccion_de_personaje(lis:Array):
	
	var jugable_1: bool
	var jugable_2: bool	
	
	lista = lis
	jugable_1 = lis[0]
	jugable_2 = lis[1]
	
	if jugable_1:
		remove_child(jugador_2)
		jugador_2.queue_free()
		return
	
	if jugable_2:
		remove_child(jugador)
		jugador.queue_free()
		return
	pass

func get_direccion_nivel_actual():
	
	for node in get_tree().get_nodes_in_group("nivel"):
		return node.scene_file_path
	
	push_error("actualmente no hay ningun nivel cargado")
	return "res://invalido.tscn"	

func en_guardado_partida(datos_guardados: Dictionary):
	var jugable: int = -1
	var con: int = 0
	
	while jugable == -1:
		if lista[con]:
			jugable = con
	
	match jugable:
		0: 
			datos_guardados["posicion_jugador_x"] = jugador.global_position.x
			datos_guardados["posicion_jugador_y"] = jugador.global_position.y
			datos_guardados["vida_jugador"] = jugador.vida.get_vida()
			datos_guardados["jugador_seleccionado"] = jugable+1
			datos_guardados["jugador_seleccionado_escena"] = jugador.scene_file_path
		1:
			datos_guardados["posicion_jugador_x"] = jugador_2.global_position.x
			datos_guardados["posicion_jugador_y"] = jugador_2.global_position.y
			datos_guardados["vida_jugador"] = jugador_2.vida.get_vida()
			datos_guardados["jugador_seleccionado"] = jugable+1
			datos_guardados["jugador_seleccionado_escena"] = jugador_2.scene_file_path


func antes_cargar_partida(datos_guardados: Dictionary):
	var jugable: int
	jugable = datos_guardados["jugador_seleccionado"]
	
	match jugable:
		1:
			remove_child(jugador_2)
			jugador_2.queue_free()
		2:
			remove_child(jugador)
			jugador.queue_free()


func en_cargado_partida(datos_guardados: Dictionary):
	var jugable: int
	jugable = datos_guardados["jugador_seleccionado"]
	
	match jugable:
		1:
			jugador.global_position.x = datos_guardados["posicion_jugador_x"]
			jugador.global_position.y = datos_guardados["posicion_jugador_y"]
			jugador.vida.set_vida(datos_guardados["vida_jugador"])
			lista = [true,false]
		2:
			jugador_2.global_position.x = datos_guardados["posicion_jugador_x"]
			jugador_2.global_position.y = datos_guardados["posicion_jugador_y"]
			jugador_2.vida.set_vida(datos_guardados["vida_jugador"])
			lista = [false,true]
	
