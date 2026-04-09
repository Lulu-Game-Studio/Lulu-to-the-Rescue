extends CharacterBody2D

var speed = 110
var health=2
var dead=false
signal frightened_enemy

func _physics_process(delta):
	if !dead:
		velocity.x = -speed
	else:
		velocity.x = 300
	move_and_slide()
	
func receives_bark():
	health-=1
	if health==0:
		dead=true
		emit_signal("frightened_enemy")
		$AnimatedSprite2D.flip_h=true
	


func _on_damage_area_body_entered(body) :
	if body.name =="Lulu":
		#get_tree().paused = true
		get_tree().current_scene.find_child("GameOver").visible = true
