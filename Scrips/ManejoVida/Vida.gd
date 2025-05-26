class_name  Vida
extends Node


signal vida_maxima_cambio(diff: int)
signal  vida_cambio(diff: int)
signal  vida_termino

@export var vida_maxima: int = 3 : set = set_vida_maxima, get = get_vida_maxima
@export var inmortalidad: bool = false : set = set_inmortalidad , get = get_inmortalidad

var inmortalidad_temporal: Timer = null

@onready var vida: int = vida_maxima : set = set_vida , get = get_vida

func set_vida_maxima(valor: int):
	var valor_fijo = 1 if valor <= 0 else valor
	
	if not valor_fijo == vida_maxima:
		var diferencia = valor_fijo - vida_maxima
		vida_maxima = valor_fijo
		vida_maxima_cambio.emit(diferencia)
		
		if vida > vida_maxima:
			vida = vida_maxima
	

func get_vida_maxima() -> int:
	return vida_maxima

func set_inmortalidad(valor: bool):
	inmortalidad = valor

func get_inmortalidad() -> bool:
	return inmortalidad

func set_inmortalidad_temporal(tiempo: float):
	if inmortalidad_temporal == null:
		inmortalidad_temporal = Timer.new()
		inmortalidad_temporal.one_shot = true
		add_child(inmortalidad_temporal)
		
	if inmortalidad_temporal.timeout.is_connected(set_inmortalidad):
		inmortalidad_temporal.timeout.disconnect(set_inmortalidad)
	inmortalidad_temporal.set_wait_time(tiempo)
	inmortalidad_temporal.timeout.connect(set_inmortalidad.bind(false))
	inmortalidad = true
	inmortalidad_temporal.start()

func set_vida(valor: int):
	if  valor < vida and inmortalidad:
		return
	print(vida)
	var valor_fijo = clampi(valor,0,vida_maxima)
	
	if valor_fijo != vida:
		var diferencia = valor_fijo - vida
		vida = valor
		vida_cambio.emit(diferencia)
		
		if vida <= 0:
			vida_termino.emit()

func get_vida():
	return vida
	
