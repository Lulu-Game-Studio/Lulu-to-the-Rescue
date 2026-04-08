extends CharacterBody2D

var action = false

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var speed = 200
	if not action:
		if direction.length() > 0:
			if Input.is_action_pressed("run"):
				$AnimatedSprite2D.play("run")
				speed=400
				$LuluStamina.value-=10*delta
			else:
				$AnimatedSprite2D.play("walk")
				$LuluStamina.value-=2*delta
		else:
			$AnimatedSprite2D.play("idle")
			$LuluStamina.value+=10*delta
		if direction.x < 0:
			$AnimatedSprite2D.flip_h = true  
		elif direction.x > 0:
			$AnimatedSprite2D.flip_h = false
			
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()
	if Input.is_action_just_pressed("jump") and not action:
		action = true
		$AnimatedSprite2D.play("jump")
	
	elif Input.is_action_just_pressed("poop") and not action:
		action = true
		$AnimatedSprite2D.play("poop")
		
	elif Input.is_action_just_pressed("ladrar") and $LuluStamina.value > 25 and not action: 
		action = true
		$LuluStamina.value-=25
		$AnimatedSprite2D.play("ladrar")
		$%barkSound.play()
		$AttackAura/bark.disabled=false
	elif Input.is_action_just_pressed("sit") and not action:
		action=true
		$AnimatedSprite2D.play("sit")
		
		await $AnimatedSprite2D.animation_finished
		$LuluStamina.value+=30
		 
	#if not action:
	
func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation=="ladrar":
		$AttackAura/bark.disabled=true
	action = false


func _on_aura_ataque_body_entered(body):
	if body.name != "Lulu":
		body.receives_bark()
