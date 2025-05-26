extends TextureProgressBar

@export var personaje: CharacterBody2D
#@onready var vida: Vida = personaje.get_node("Vida")
@onready var vida: Vida = personaje.find_children("*","Vida")[0]

func _ready() -> void:
	max_value = vida.vida_maxima
	value = vida.vida
	vida.vida_cambio.connect(_actualizar_barra)

func _actualizar_barra(_diff: int) -> void:
	value = vida.get_vida()
	
