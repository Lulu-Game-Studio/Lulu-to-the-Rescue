extends Node2D
var enemigos_spawneados=0
var muertos_totales=0
func spawn_mob():
	var new_mob = preload("res://enemigo_1.tscn").instantiate()
	var num_aleatorio = str(randi() % 3)
	var nodo_carril = get_node("%PathFollow2D_" + num_aleatorio)
	
	if nodo_carril and enemigos_spawneados<5:
		nodo_carril.progress_ratio = randf()
		new_mob.global_position = nodo_carril.global_position
		new_mob.enemigo_ahuyentado.connect(_on_enemigo_muerto)
		add_child(new_mob)
		enemigos_spawneados+=1
		
		
				
		
func _on_enemigo_muerto():
	muertos_totales += 1
	if muertos_totales == 5:
		$Ronda1_finalizada.visible = true

func _on_timer_timeout() -> void:
	spawn_mob()
	

func _on_zonallegada_body_entered(body):
	%GameOver.visible=true	


func _on_button_pressed():
	get_tree().reload_current_scene()
	


func _on_inicio_r_onda_2_timeout() -> void:
	$Ronda1_finalizada.visible = false
