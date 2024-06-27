extends CenterContainer

onready var tween = $Tween
onready var suara_info = $suarainfo
signal info_setPlayerMoveByController(value)

onready var infoLabel = $VBoxContainer/LabelInfo

# akan di link kan dengan node levelxx, di lakukan di _ready()
var parent_node = null
# stageNow di ambil dari parent_node, di lakukan di _ready() 
var stageNow = 0
# merefer dari sign / papan yang tersentuh player. beda sign, maka akan beda juga text / info yg muncul
var idInfo = 0


func _ready():
	parent_node = get_parent().get_parent() # get parent node, biasanya adalah Level1, Level2, Level3 dst
	stageNow = parent_node.getStage() # dari parent node kita bisa mengetahui saat ini stage berapa? apakah stageNow = 1. stageNow = 2. stageNow = 3 dst dst  
	stageNow = parent_node.getStage() # dari parent node kita bisa mengetahui saat ini stage berapa? apakah stageNow = 1. stageNow = 2. stageNow = 3 dst dst  
	
func muncul():
	# memunculkan gui, dengan animasi menggunakan tween
	tween.interpolate_property(self, "rect_position:y", -231, 25, 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.start()
	suara_info.play() # Mainkan suara popup info


func _on_Sign01_body_entered(body):
	# jika cooldown sign sudah habis maka, sign akan mengeluarkan info
	if body.canCheckPoint_dueToTime == true:
		loadInfoGui(1, body) # load info GUI
		
func _on_Sign02_body_entered(body):
	# jika cooldown sign sudah habis maka, sign akan mengeluarkan info
	if body.canCheckPoint_dueToTime == true:
		loadInfoGui(2, body) # load info GUI
	
func _on_Sign03_body_entered(body):
	# jika cooldown sign sudah habis maka, sign akan mengeluarkan info
	if body.canCheckPoint_dueToTime == true:
		loadInfoGui(3, body) # load info GUI

func _on_ButtonOk_pressed():
	emit_signal("info_setPlayerMoveByController", true) # hero dan enemy bisa bebas bergerak lagi
	self.visible = false # gui kita sembunyikan dari tampilan user
	$SoundTombol.play()

func loadInfoGui(setIdSign , body):
	body.resetTimePass() # reset cooldown checkpoint agar tidak popup terus menerus 
	idInfo = setIdSign # set info number, based on sign yang tersentuh
	loadDataSign() # load data, dimana acuan data adalah stageNow dan idInfo
	
	muncul() # munculkan Info, dengan animasi menggunakan tween
	emit_signal("info_setPlayerMoveByController", false) # hentikan waktu hero dan enemy. agar user player bisa baca info dengan tenang dan tidak terburu buru
	parent_node.CheckpointGame_state() # save checkpoint
	
func loadDataSign():
	# text info default kita buat blank
	infoLabel.text = ""
	self.visible = true # gui kita tampilkan
#	========================== untuk Stage 1
	if stageNow == 1 :
		# untuk stage 1, sign01 
		if idInfo == 1: 
			infoLabel.text = """Kelahiran Yesus Kristus adalah momen
								yang sangat penting dalam sejarah kekristenan,
								di mana Anak Allah lahir ke dunia sebagai bayi
								manusia. Yesus dilahirkan di kota Betlehem. 
								Ini memenuhi nubuat-nubuat dalam Alkitab,
								seperti yang disebutkan dalam kitab Yesaya 7:14,
								di mana seorang perempuan akan mengandung dan
								melahirkan seorang anak laki-laki yang
								akan dinamai Imanuel. """
		# untuk stage 1, sign02 
		if idInfo == 2:
			infoLabel.text = """Yesus dibesarkan di Nazaret oleh Yusuf dan Maria. 
								Mereka hidup dalam keluarga yang sederhana, 
								Yusuf adalah seorang tukang kayu yang rajin. 
								Maria, dengan penuh kasih, menjaga rumah tangga 
								mereka sambil membimbing dan mendidik Yesus.
								"Dan Ia datang ke Nazaret, tempat Ia dibesarkan, 
								dan masuk ke rumah ibadat pada hari Sabat, 
								sesuai dengan kebiasaan-Nya. Dan Ia berdiri untuk membacakan." 
								(Lukas 4:16) """
		# untuk stage 1, sign03
		if idInfo == 3:
			infoLabel.text = """Pencegahan kanker 
								gaya hidup sehat, berhenti merokok, 
								mengurangi konsumsi alkohol, 
								makan makanan sehat, dan rutin berolahraga.
								Deteksi dini sangat penting untuk 
								meningkatkan peluang kesembuhan.."""
	
#	========================== untuk Stage 2
	if stageNow == 2 :
		# untuk stage 2, sign01 
		if idInfo == 1:
			infoLabel.text = """Pembabtisan Tuhan Yesus
			
								Yesus datang dari Galilea ke Sungai Yordan 
								untuk bertemu dengan Yohanes Pembaptis untuk 
								dibaptis. Setelah Yesus dibaptis, terjadi suatu 
								peristiwa luar biasa: langit terbuka dan Roh 
								Allah turun seperti burung merpati, sementara 
								suara dari langit mengakui Yesus sebagai Anak 
								Allah yang dikasihi.
								Matius, pasal 3, ayat 13-17"""
		# untuk stage 2, sign02 
		if idInfo == 2:
			infoLabel.text = """Setelah berpuasa selama empat puluh hari dan empat
								puluh malam di padang gurun, Yesus diuji oleh Iblis. 
								Iblis mencoba menggoda-Nya dengan tiga godaan yang 
								berbeda. Pertama, Iblis menawarkan Yesus untuk 
								mengubah batu menjadi roti karena Yesus kelaparan, 
								tetapi Yesus menjawab bahwa "Manusia hidup bukan 
								hanya dari roti, tetapi juga dari setiap firman 
								yang keluar dari mulut Allah".
								Matius, pasal 4, ayat 1-11."""
		# untuk stage 2, sign03
		if idInfo == 3:
			infoLabel.text = """Kedua, Iblis membawa Yesus ke atas pelataran
								Bait Allah dan mengajak-Nya melompat dari sana tetapi 
								Yesus menolak dengan mangatakan, "Janganlah engkau mencobai 
								Tuhan, Allahmu." Terakhir, Iblis menunjukkan segala kerajaan 
								dunia dan kemuliaannya kepada Yesus, menawarkan untuk 
								memberikan semuanya kepada-Nya jika Yesus mau menyembahnya. 
								Namun, Yesus menolak dengan tegas, mengatakan bahwa 
								"Enyahlah, Iblis, sebab ada tertulis: Engkaulah yang harus 
								menyembah Tuhan, Allahmu, dan hanya kepada 
								Dia sajalah engkau berbakti." Matius 4 : 1 - 11"""
	
#	========================== untuk Stage 3
	if stageNow == 3 :
		# untuk stage 3, sign01 
		if idInfo == 1:
			infoLabel.text = """12 Murid Yesus, Matius 4:18-22
								Yesus bertemu dengan Simon Petrus, Andreas, Yakobus, dan 
								Yohanes, yang semuanya merupakan nelayan di danau Galilea. 
								Yesus memanggil mereka untuk mengikuti-Nya, dengan janji 
								bahwa Dia akan menjadikan mereka "penjala manusia". Para 
								murid dengan cepat meninggalkan pekerjaan dan keluarga 
								mereka untuk mengikuti Yesus. Ini adalah permulaan dari 
								pelayanan langsung para murid kepada Yesus"""
		# untuk stage 3, sign02 
		if idInfo == 2:
			infoLabel.text = """12 Murid Yesus
								Matius, seorang pemungut cukai, dipanggil oleh Yesus saat
								sedang bekerja. Yesus berkata, "Ikutlah Aku!" (Matius 9:9)
								Tomas, Ia terkenal dengan julukan "Tomas yang Ragawan" 
								karena keraguan dan ketidakpercayaannya (Yohanes 20:28)
								Filipus, berasal dari Betsaida, dipanggil oleh Yesus ketika 
								Yesus hendak pergi ke Galilea. (Yohanes 1:43-45)"""
		# untuk stage 3, sign03
		if idInfo == 3:
			infoLabel.text = """12 Murid Yesus
								Bartolomeus: Dipanggil oleh Filipus, ia maragukan messias
								bisa barsasal dari nazaret tapi setelah bertemu Yesus
								Bartolomeus mengakui Yesus sebagai Mesias . (Yohanes 1:47)
								Yudas Iskariot, Salah satu dari kedua belas rasul, 
								Yudas akhirnya mengkhianati Yesus. (Matius 26:14-16)"""
