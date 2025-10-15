extends Area2D

@export var nombre_interaccion: String = ""
@export var es_interactuable: bool = true

#Es un metodo de la interaccion que nos permite definir una funcion 
# permite de esta forma difinir el comportamineto de la interaccion
# a travez del codigo de los objetos a los que queramos interactuar 
var interaccion: Callable = func():
	pass
	
