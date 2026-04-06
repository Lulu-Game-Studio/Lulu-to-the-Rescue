extends CharacterBody2D

var accion = false

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var speed = 200
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true  
	elif direction.x > 0:
		$AnimatedSprite2D.flip_h = false
		
	if Input.is_action_pressed("run") and direction.length() > 0:
		speed = 400 
		
	velocity = direction * speed
	move_and_slide()
	if Input.is_action_just_pressed("jump"):
		accion = true
		$AnimatedSprite2D.play("jump")
	
	elif Input.is_action_just_pressed("poop"):
		accion = true
		$AnimatedSprite2D.play("poop")
		
	elif Input.is_action_just_pressed("ladrar"):
		accion = true
		$AnimatedSprite2D.play("ladrar")
		$AuraAtaque/ladrido.disabled=false
	if not accion:
		if direction.length() > 0:
			if Input.is_action_pressed("run"):
				$AnimatedSprite2D.play("run")
			else:
				$AnimatedSprite2D.play("walk")
		else:
			$AnimatedSprite2D.play("idle")


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation=="ladrar":
		$AuraAtaque/ladrido.disabled=true
	accion = false


func _on_aura_ataque_body_entered(body):
	if body.name != "Lulu":
		body.recibe_ladrido()
