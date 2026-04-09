extends Node2D
var spawned_enemies=0
var frightened_people=0
func spawn_mob():
	var randomNumber = str(randi() % 3)
	var lane_node = get_node("%PathFollow2D_" + randomNumber)
	
	lane_node.progress_ratio = randf()
	var new_mob
	if frightened_people < 5 and spawned_enemies < 5:
		new_mob = preload("res://enemy_1.tscn").instantiate()
	elif frightened_people >= 5 and frightened_people < 10 and spawned_enemies < 10:
		new_mob = preload("res://enemy_2.tscn").instantiate()
	elif frightened_people >= 10 and frightened_people<=13 and spawned_enemies<=13:
		new_mob = preload("res://cat.tscn").instantiate()
	if new_mob:
		new_mob.global_position = lane_node.global_position
		new_mob.frightened_enemy.connect(enemy_dead)
		add_child(new_mob)
		spawned_enemies += 1
		
func enemy_dead():
	frightened_people += 1
	
	if frightened_people == 5:	
		%Timer.start()
		%round1_completed.visible = true
		%startRound2.start() 
	if frightened_people == 10:
		%Timer.start()
		%round2_completed.visible = true
		%startRound3.start()
	if frightened_people ==13:
		%winningPanel.visible = true

func _on_timer_timeout() -> void:
	spawn_mob()
	
func _on_button_pressed():
	get_tree().reload_current_scene()
	
func _on_start_round_2_timeout() -> void:
	$round1_completed.visible = false
	

func _on_start_round_3_timeout() -> void:
	$round2_completed.visible = false
	
func _on_arrival_zone_body_entered(body):
		%GameOver.visible=true	


func _on_play_again_pressed():
	get_tree().reload_current_scene()


func _on_exit_pressed():
	get_tree().quit()
