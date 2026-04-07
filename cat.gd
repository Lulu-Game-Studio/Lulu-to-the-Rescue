extends CharacterBody2D

var speed = 180 
var health = 1
var dead = false
signal frightened_enemy
var lanesPositionY = [-70, 60, 190] 
var carril_actual = 1 

func _ready():
	$laneChangeTimer.start()

func _physics_process(delta):
	if !dead:
		velocity.x = -speed
		var objetivo_y = lanesPositionY[carril_actual]
		global_position.y = lerp(global_position.y, float(objetivo_y), 0.04)
	else:
		velocity.x = 400
		$AnimatedSprite2D.flip_h = true
		
	move_and_slide()

func receives_bark():
	health-=1
	if health==0:
		dead=true
		emit_signal("frightened_enemy")
		$AnimatedSprite2D.flip_h=true
	
func changeLane():
	var newLane = randi() % 3
	while newLane == carril_actual:
		newLane = randi() % 3
	carril_actual = newLane

func _on_lane_change_timer_timeout() -> void:
	if !dead:
		changeLane()
		


func _on_damage_area_body_entered(body):
	if body.name =="Lulu":
		#get_tree().paused = true
		get_tree().current_scene.find_child("GameOver").visible = true
