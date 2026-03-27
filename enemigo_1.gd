extends CharacterBody2D

var velocidad = 50
var health=2
var muerto=false
signal enemigo_ahuyentado

func _physics_process(delta):
	if !muerto:
		velocity.x = -velocidad
	else:
		velocity.x = 300
	move_and_slide()
	
func recibe_ladrido():
	health-=1
	if health==0:
		muerto=true
		emit_signal("enemigo_ahuyentado")
		$AnimatedSprite2D.flip_h=true
	
