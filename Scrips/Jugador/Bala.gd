extends Area2D

var velocidad = 300
var direccion = 1


func _process(delta: float) -> void:
	position.x += velocidad * direccion * delta
