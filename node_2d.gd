extends Node2D
var spawned_enemies=0
var frightened_people=0
func spawn_mob():
	var randomNumber = str(randi() % 3)
	var lane_node = get_node("%PathFollow2D_" + randomNumber)
	
	lane_node.progress_ratio = randf()
	var new_mob
	if frightened_people < 5 and spawned_enemies < 5:
		new_mob = preload("res://enemigo_1.tscn").instantiate()
	elif frightened_people >= 5 and frightened_people < 10 and spawned_enemies < 10:
		new_mob = preload("res://enemigo_2.tscn").instantiate()
	elif frightened_people >= 10:
		new_mob = preload("res://cat.tscn").instantiate()
	if new_mob:
		new_mob.global_position = lane_node.global_position
		new_mob.frightened_enemy.connect(_on_enemigo_muerto)
		add_child(new_mob)
		spawned_enemies += 1
		
func _on_enemigo_muerto():
	frightened_people += 1
	if frightened_people == 5:
		$round1_completed.visible = true
	if frightened_people==10:
		%round2_completed.visible=true

func _on_timer_timeout() -> void:
	spawn_mob()
	

func _on_zonallegada_body_entered(body):
	%GameOver.visible=true	
	#get_tree().paused = true


func _on_button_pressed():
	get_tree().reload_current_scene()
	


func _on_inicio_r_onda_2_timeout() -> void:
	$round1_completed.visible = false


func _on_inicio_r_onda_3_timeout() -> void:
	$round2_completed.visible = false
