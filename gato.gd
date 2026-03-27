extends CharacterBody2D

var velocidad =150
var health=1

func _physics_process(delta):
	velocity.x = -velocidad
	move_and_slide()
