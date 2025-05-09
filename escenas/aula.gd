extends Node2D


func  _ready() -> void:
	if ManejoNavegacion.etiqueta_puerta_spawn != null:
		_on_level_spawn(ManejoNavegacion.etiqueta_puerta_spawn)
		
func _on_level_spawn(etiqueta_destinacion: String):
	var puerta_ruta = "Puertas/puerta " + etiqueta_destinacion
	var puerta = get_node(puerta_ruta) as Puerta
	ManejoNavegacion.trigger_player_spawn(puerta.spawn.global_position, puerta.salida_dirreccion)
