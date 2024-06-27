extends CenterContainer

#onready var tween = $Tween
#var sudah_muncul = false
# Called when the node enters the scene tree for the first time.
#func _ready():
#	muncul()

func show_popup():
	# Menampilkan pop-up
	visible = true
	# Tambahkan kode lain jika diperlukan, seperti animasi atau mengatur fokus

func _on_TombolKembali_pressed():
	hide_popup()
	
func hide_popup():
	# Menyembunyikan pop-up
	visible = false
	
#func muncul():
#	if not sudah_muncul:
#		sudah_muncul = true
#		muncul()
	
#		tween.interpolate_property(self, "rect_position:y", -300, -5, 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
#		tween.start()
