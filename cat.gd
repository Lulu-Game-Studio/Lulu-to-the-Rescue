extends CharacterBody2D

var speed = 200 
var health = 2
var dead = false
signal frightened_enemy
var lanesPositionY = [-70, 60, 190] 
var actual_lane = 1 

func _ready():
	$laneChangeTimer.start()

func _physics_process(delta):
	if !dead:
		velocity.x = -speed
		var objetivo_y = lanesPositionY[actual_lane]
		global_position.y = lerp(global_position.y, float(objetivo_y), 0.07)
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
	while newLane == actual_lane:
		newLane = randi() % 3
	actual_lane = newLane

func _on_lane_change_timer_timeout() -> void:
	if !dead:
		changeLane()
		


func _on_damage_area_body_entered(body):
	if body.name =="Lulu":
		#get_tree().paused = true
		get_tree().current_scene.find_child("GameOver").visible = true
