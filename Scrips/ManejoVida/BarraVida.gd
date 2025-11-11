extends TextureProgressBar

@onready var raiz_mundo: RaizMundo = %RaizMundo

@onready var personaje: CharacterBody2D
#@onready var vida: Vida = personaje.get_node("Vida")
@onready var vida: Vida  

func _ready() -> void:
	personaje = raiz_mundo.jugador_seleccionado
	vida = personaje.find_children("*","Vida")[0]
	max_value = vida.vida_maxima
	value = vida.vida
	vida.vida_cambio.connect(_actualizar_barra)
	
func _actualizar_barra(_diff: int) -> void:
	value = vida.get_vida()
	
