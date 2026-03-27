extends CharacterBody2D

var velocidad = 100

func _physics_process(delta):
	velocity.x = -velocidad
	move_and_slide()
