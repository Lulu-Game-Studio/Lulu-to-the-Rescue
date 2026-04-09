extends Area2D


func _on_body_entered(body):
	if body.name != "Lulu":
		var mapa=get_parent()
		mapa.frightened_people+=1
		body.queue_free() 
		queue_free()
