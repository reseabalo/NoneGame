extends Node2D

@onready var interaccion_label: Label = $InteraccionLabel
var interacciones_actuales:= []
var puede_interactuar := true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interactuar") and puede_interactuar:
		if interacciones_actuales:
			puede_interactuar = false
			interaccion_label.hide()
			
			#espera a que se llame a la funcion que tenga la interaccion que a la
			# que valga la redundacia hallamos interactuado
			await interacciones_actuales[0].interaccion.call()
			
			puede_interactuar = true

func _process(_delta: float) -> void:
	if interacciones_actuales and puede_interactuar:
		interacciones_actuales.sort_custom(_ordenar_por_cercania)
		#muestra el nombre que tenga la interaccion. ej: podar bonsai.
		if interacciones_actuales[0].es_interactuable:
			interaccion_label.text = interacciones_actuales[0].nombre_interaccion
			interaccion_label.show()
	else:
		interaccion_label.hide()

#funcion que se encarga de mostrar el texto de la interaccion mas cercana al el personaje.
func _ordenar_por_cercania(area1, area2):
	var area1_distancia = global_position.direction_to(area1.global_position)
	var area2_distancia = global_position.direction_to(area2.global_position)
	return area1_distancia < area2_distancia

#se engarga de agregar a una lista las interacciones que a las que hallamos entrado.
func _on_rango_interaccion_area_entered(area: Area2D) -> void:
	interacciones_actuales.push_back(area)

#borra de la lista la interaccion de la que hallamos salido.
func _on_rango_interaccion_area_exited(area: Area2D) -> void:
	interacciones_actuales.erase(area)
