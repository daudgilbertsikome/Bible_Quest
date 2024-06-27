extends Control

onready var tween = $Tween
onready var quizOpenSound = $QuizOpenSound# Referensi ke AudioStreamPlayer
# ambil parent node

# Called when the node enters the scene tree for the first time.
var quizData1 = {"soal":"","pilihan1":"","pilihan2":"","pilihan3":"","kunciJawaban":""}
var quizData2 = {"soal":"","pilihan1":"","pilihan2":"","pilihan3":"","kunciJawaban":""}
var quizData3 = {"soal":"","pilihan1":"","pilihan2":"","pilihan3":"","kunciJawaban":""}

var listQuiz = []
var listQuizUsed = null
var playerAnswer = []
var playerCorrect = 0
var minCorrectToWin = 2
var totalSoal = 3
var soalNow = 0
var hero = null

onready var soal = get_node("VBoxContainerSoal/LabelSoal")
onready var pilihan1 = get_node("VBoxContainerSoal/ButtonAnswer01")
onready var pilihan2 = get_node("VBoxContainerSoal/ButtonAnswer02")
onready var pilihan3 = get_node("VBoxContainerSoal/ButtonAnswer03")
onready var soalMode = get_node("VBoxContainerSoal")
onready var jawabanMode = get_node("VBoxContainerJawaban")

onready var iconJawaban1 = get_node("VBoxContainerJawaban/HBoxContainer1/CorrectWrongSign1")
onready var iconJawaban2 = get_node("VBoxContainerJawaban/HBoxContainer2/CorrectWrongSign2")
onready var iconJawaban3 = get_node("VBoxContainerJawaban/HBoxContainer3/CorrectWrongSign3")
onready var textJawaban1 = get_node("VBoxContainerJawaban/HBoxContainer1/LabelJawabanDipilih1")
onready var textJawaban2 = get_node("VBoxContainerJawaban/HBoxContainer2/LabelJawabanDipilih2")
onready var textJawaban3 = get_node("VBoxContainerJawaban/HBoxContainer3/LabelJawabanDipilih3") 

onready var btnRetry = get_node("VBoxContainerJawaban/LabelBlank/ButtonRetry")
onready var spaceXspace = get_node("VBoxContainerJawaban/LabelBlank/LabelSpace")
onready var btnWinQuiz = get_node("VBoxContainerJawaban/LabelBlank/ButtonNextLevel")

onready var popUpMenang = get_parent().get_node("PopupMenang")

# akan di link kan dengan node levelxx, di lakukan di _ready()
var parent_node = null
# stageNow di ambil dari parent_node, di lakukan di _ready() 
var stageNow = 0

signal info_setPlayerMoveByController(value)

func _ready():
	parent_node = get_parent().get_parent() # get parent node, biasanya adalah Level1, Level2, Level3 dst
	stageNow = parent_node.getStage() # dari parent node kita bisa mengetahui saat ini stage berapa? apakah stageNow = 1. stageNow = 2. stageNow = 3 dst dst  
	hero = get_parent().get_parent().get_node("Hero") # dapatkan hero 

func muncul():
	# ketika gui pertama kali muncul, maka soal yang akan di tampilkan terlebih dahulu
	modeSoalActive() # jalankan mode soal
	
	self.visible = true # tampilkan GUI
	tween.interpolate_property(self, "rect_position:y", -231, 25, 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT) # lakukan animasi muncul
	tween.start() # jalankan animasi 
	# Putar suara saat quiz popup muncul
	quizOpenSound.play()
	

func load_bank_soal():
	# ========================== bank soal untuk stage 1
	if stageNow == 1:
		# ---------------------- bank soal stage 1, Quiz 1
		quizData1["soal"] = "1. Apa Profesi Yusuf? "
		quizData1["pilihan1"] = "A. Nelayan"
		quizData1["pilihan2"] = "B. Tukang Batu"
		quizData1["pilihan3"] = "C. Tukang Kayu"
		quizData1["kunciJawaban"] = 3  # kunci jawaban dari soal. 1 berarti pilihan1 adalah jawaban yg benar, 2 berarti pilihan2 adalah jawaban yg benar, 3 berarti pilihan3 adalah jawaban yg benar, 
		listQuiz.append(quizData1) 
		# ---------------------- bank soal stage 1, Quiz 2
		quizData2["soal"] = "2. Dimana Kota Yesus Dilahirkan "
		quizData2["pilihan1"] = """A. Yerusalem"""
		quizData2["pilihan2"] = "B. Betlehem."
		quizData2["pilihan3"] = """C. Nazaret
									"""
		quizData2["kunciJawaban"] = 2 # kunci jawaban dari soal. 1 berarti pilihan1 adalah jawaban yg benar, 2 berarti pilihan2 adalah jawaban yg benar, 3 berarti pilihan3 adalah jawaban yg benar, 
		listQuiz.append(quizData2)
		# ---------------------- bank soal stage 1, Quiz 3
		quizData3["soal"] = "3. Kota mana yang menjadi tempat Yesus dibesarkan selama masa kecil-Nya? "
		quizData3["pilihan1"] = "A. Nazaret"
		quizData3["pilihan2"] = "B. Betlehem"
		quizData3["pilihan3"] = "C. Yerusalem"
		quizData3["kunciJawaban"] = 1 # kunci jawaban dari soal. 1 berarti pilihan1 adalah jawaban yg benar, 2 berarti pilihan2 adalah jawaban yg benar, 3 berarti pilihan3 adalah jawaban yg benar, 
		listQuiz.append(quizData3)
		
	# ========================== bank soal untuk stage 2
	if stageNow == 2:
		# ---------------------- bank soal stage 2, Quiz 1
		quizData1["soal"] = """1. Dimana Yesus di babtis dan oleh siapa?"""
		quizData1["pilihan1"] = """A. Galiea, di babtis 
									oleh Simon"""
		quizData1["pilihan2"] = """B. Sungai Yordan, 
									dibabtis oleh Yohanes"""
		quizData1["pilihan3"] = """C. Nazaret, dibabtis
									 oleh Yusuf"""
		quizData1["kunciJawaban"] = 2  # kunci jawaban dari soal. 1 berarti pilihan1 adalah jawaban yg benar, 2 berarti pilihan2 adalah jawaban yg benar, 3 berarti pilihan3 adalah jawaban yg benar, 
		listQuiz.append(quizData1) 
		# ---------------------- bank soal stage 2, Quiz 2
		quizData2["soal"] = """2. Apa yang dikatakan oleh Yesus ketika Iblis mengajak-Nya melompat dari atas pelataran Bait Allah?"""
		quizData2["pilihan1"] = """A. Tinggalkanlah Aku, sebab Aku tidak
									 akan tunduk kepadamu."""
		quizData2["pilihan2"] = """B. "Engkaulah yang harus 
									menyembah Tuhan, Allahmu"."""
		quizData2["pilihan3"] = """C. "Janganlah engkau 
									mencobai Tuhan, Allahmu"."""
		quizData2["kunciJawaban"] = 3 # kunci jawaban dari soal. 1 berarti pilihan1 adalah jawaban yg benar, 2 berarti pilihan2 adalah jawaban yg benar, 3 berarti pilihan3 adalah jawaban yg benar, 
		listQuiz.append(quizData2)
		# ---------------------- bank soal stage 2, Quiz 3
		quizData3["soal"] = "3. . Injil dan ayat berapa saat Yesus di goda oleh iblis?"
		quizData3["pilihan1"] = "A. Matius 4 : 1-11"
		quizData3["pilihan2"] = "B. Matius 2 : 1-10"
		quizData3["pilihan3"] = "C. Lukas 2 : 1-5"
		quizData3["kunciJawaban"] = 1 # kunci jawaban dari soal. 1 berarti pilihan1 adalah jawaban yg benar, 2 berarti pilihan2 adalah jawaban yg benar, 3 berarti pilihan3 adalah jawaban yg benar, 
		listQuiz.append(quizData3)

	# ========================== bank soal untuk stage 3
	if stageNow == 3:
		# ---------------------- bank soal stage 2, Quiz 1
		quizData1["soal"] = """1. Siapa diantara 12 murid Yesus yang merupakan seorang pemungut cukai sebelum di panggil Yesus?"""
		quizData1["pilihan1"] = """A. Tomas"""
		quizData1["pilihan2"] = "B. Matius"
		quizData1["pilihan3"] = """C. Bartolomeus"""
		quizData1["kunciJawaban"] = 2  # kunci jawaban dari soal. 1 berarti pilihan1 adalah jawaban yg benar, 2 berarti pilihan2 adalah jawaban yg benar, 3 berarti pilihan3 adalah jawaban yg benar, 
		listQuiz.append(quizData1) 
		# ---------------------- bank soal stage 2, Quiz 2
		quizData2["soal"] = """2. Dimana awal pelayanan Yesus?"""
		quizData2["pilihan1"] = "A. Yordan"
		quizData2["pilihan2"] = "B. Yerusalem"
		quizData2["pilihan3"] = "C. Galilea"
		quizData2["kunciJawaban"] = 3 # kunci jawaban dari soal. 1 berarti pilihan1 adalah jawaban yg benar, 2 berarti pilihan2 adalah jawaban yg benar, 3 berarti pilihan3 adalah jawaban yg benar, 
		listQuiz.append(quizData2)
		# ---------------------- bank soal stage 2, Quiz 3
		quizData3["soal"] = "3. Siapa murid pertama Yesus?"
		quizData3["pilihan1"] = """A. Simon Petrus"""
		quizData3["pilihan2"] = """B. Yohanes"""
		quizData3["pilihan3"] = """C. Filipus"""
		quizData3["kunciJawaban"] = 1 # kunci jawaban dari soal. 1 berarti pilihan1 adalah jawaban yg benar, 2 berarti pilihan2 adalah jawaban yg benar, 3 berarti pilihan3 adalah jawaban yg benar, 
		listQuiz.append(quizData3)
func load_soal_pilihan():
	# load soal di gui sesuai soal yang sedang berjalan (bisa soal1, soal2, atau soal3, sesuai alur sebelumnya)
	listQuizUsed = listQuiz[soalNow]
	soal.text = listQuizUsed["soal"] # isi soal
	pilihan1.text = listQuizUsed["pilihan1"] # isi text untuk pilihan ganda 1
	pilihan2.text = listQuizUsed["pilihan2"] # isi text untuk pilihan ganda 2
	pilihan3.text = listQuizUsed["pilihan3"] # isi text untuk pilihan ganda 3
	
	# visible di matikan dan di nyalakan untuk meng counter bug, text overhead
	pilihan1.visible = false
	pilihan2.visible = false
	pilihan3.visible = false
	pilihan1.visible = true
	pilihan2.visible = true
	pilihan3.visible = true

func _on_ButtonAnswer01_button_up():
	submitAnswer(1)	 # simpan jawaban 1 untuk soalNow 

func _on_ButtonAnswer02_button_up():
	submitAnswer(2)	# simpan jawaban 2 untuk soalNow 

func _on_ButtonAnswer03_button_up():
	submitAnswer(3)	# simpan jawaban 3 untuk soalNow 


func _on_Npc_body_entered(_body):
	# NPC Quiz tersentuh oleh hero!
	self.visible = true # nyalakan gui quiz
	muncul() # tampilkan gui quiz
	emit_signal("info_setPlayerMoveByController", false) # hentikan waktu hero dan enemy. agar user player bisa jawab quiz dengan tenang dan tidak terburu buru
	
func submitAnswer(jawaban_user):
	# simpan jawaban player, dengan key is_correct ,yang dimana yg disimpan adalah benar atau salah pilihan ganda, yang telah di bandingkan dengan kunci jawaban
	# simpan jawaban player, dengan key text_pilihan , yang dimana yg disimpan adalah text pilihan ganda di var text_pilihan
	playerAnswer.append({ "is_correct": listQuizUsed["kunciJawaban"] == jawaban_user ,
						  "text_pilihan" : listQuizUsed["pilihan" + str(jawaban_user)] })
	
	# setelah player menjawab pertanyaan, ideal nya adalah load soal baru.
	# tapi jika ini sudah soal terakhir, maka buka page "mode jawaban"
	if soalNow < (totalSoal -1 ):
		soalNow = soalNow + 1
		# load soal baru
		load_soal_pilihan()	
	else:
		# buka mode jawaban
		modeJawabanActive()

func modeSoalActive():
	# mode soal, kita kosongkan semua variable pertanyaan juga jawaban, 
	# untuk pertanyaan, akan di load di function bank soal
	listQuiz = []
	listQuizUsed = null
	playerAnswer = []
	
	
	soalNow = 0
	load_bank_soal() # load bank soal
	load_soal_pilihan()  # load soal sesuai dengan stage dan soal yang sedang akan dikerjakan
	
	soalMode.visible = true # tampilan page soal di nyalakan
	jawabanMode.visible = false	 # tampilan page jawaban di sembunyikan
	

func modeJawabanActive():
	soalMode.visible = false # tampilan page soal di sembunyikan
	jawabanMode.visible = true # tampilan page jawaban di nyalakan
	print(playerAnswer) # debug. ingin memastikan jawaban player apa
	iconJawaban1.setCorrect(playerAnswer[0]["is_correct"]) #tampilkan icon, correct atau wrong untuk soal 1
	iconJawaban2.setCorrect(playerAnswer[1]["is_correct"]) #tampilkan icon, correct atau wrong untuk soal 2
	iconJawaban3.setCorrect(playerAnswer[2]["is_correct"]) #tampilkan icon, correct atau wrong untuk soal 3
	textJawaban1.text = "1. - " + playerAnswer[0]["text_pilihan"] #tampilkan jawaban yang telah dipilih untuk soal 1
	textJawaban2.text = "2. - " + playerAnswer[1]["text_pilihan"] #tampilkan jawaban yang telah dipilih untuk soal 2
	textJawaban3.text = "3. - " + playerAnswer[2]["text_pilihan"] #tampilkan jawaban yang telah dipilih untuk soal 3
	
	var conditionResult = calcWinCondition()
	
	loadLoseGui() # default lose gui akan muncul
	if conditionResult == 'win': # jika player min dengan nilai minimal, maka gui win akan muncul
		loadWinGui()
	if conditionResult == 'perfect': # jika player menang dengan score max, maka gui perfect akan muncul
		loadPerfectGui()
		

func _on_ButtonRetry_pressed():
	emit_signal("info_setPlayerMoveByController", true) # player bisa kembali bergerak
	self.visible = false # matikan / sembunyikan GUI Quiz

func calcWinCondition():
	playerCorrect = 0
	# loop masing masing soal
	for noSoal in range (0,totalSoal):
		# check apakah jawaban yg dipilih benar		
		if playerAnswer[noSoal]["is_correct"]:
			playerCorrect += 1 # setiap jawaban benar, Score jawaban di tambah 1
	
	var result = 'lose' # default result adalah lose
	if playerCorrect >= minCorrectToWin: # jika benar dengan nilai minimal, maka win
		result = 'win'
	if playerCorrect == totalSoal:  # jika benar semua, maka perfect
		result = 'perfect'
	
	return result
		
func loadWinGui():
	# tombol retry dan win akan muncul
	btnRetry.visible = true
	spaceXspace.visible = true
	btnWinQuiz.visible = true

func loadPerfectGui():
	# hanya tombol win akan muncul
	btnRetry.visible = false
	spaceXspace.visible = false
	btnWinQuiz.visible = true

func loadLoseGui():
	# hanya tombol retry akan muncul
	btnRetry.visible = true
	spaceXspace.visible = false
	btnWinQuiz.visible = false
	


func _on_ButtonNextLevel_pressed():
	self.visible = false
	yield(get_tree().create_timer(0.5), "timeout")
	hero.heroWin()
