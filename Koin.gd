extends Area2D

onready var coin_sound = $AudioStreamPlayer2D # Referensi ke node AudioStreamPlayer2D

func _on_Koin_body_entered(body):
	if body.name == 'Hero':
		coin_sound.play()
		var _efekkoin = preload("res://EfekKoin.tscn")
		var efekkoin = _efekkoin.instance()
		efekkoin.transform = self.transform
		get_tree().current_scene.add_child(efekkoin)
		remove_from_group("GrupKoin")
		body.ambil_koin()
		
		
		hapus()
	

# digunakan ketika 
func hapus():
	queue_free()
