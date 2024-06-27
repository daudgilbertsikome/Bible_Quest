extends Node

# path untuk save
onready var saveCheckPointPath = "user://save_checkpoint_game.json"


var save_data = {
	"enemy": [],  # List to store enemy data
	"coin": [],
	"hero": {
		"position": Vector2.ZERO,
		"health": 100,  
		"koin": 0,
	},
	"stage": 0,
	
}

func save_game_state(currentStage):
	# get nama nodes agar bisa di loop dengan cara mendapatkan child dari node parent
	var groupEnemy = currentStage.get_node('GroupMusuh').get_children()
	var groupCoin = currentStage.get_node('TempatKoin').get_children()
	# Gather enemy data
#	save_data["stage"] = currentNode.stageNow
	print(currentStage.stageNow)
	# reset data before save
	save_data["enemy"] = []
	save_data["coin"] = []
	save_data['stage'] = currentStage.stageNow
	for enemy in groupEnemy:  # Assuming musuh ada di group
		if enemy.hp > 0:
			save_data["enemy"].append(
				{"name": enemy.name}
	##			other params aku disable karena overkill 
	#			"position": enemy.global_position,
	#			"hp": enemy.hp,  # Assuming enemy has a "health" property
	#			"arah": enemy.arah,  # Assuming enemy has a "health" property
			)
	for coin in groupCoin:  # Assuming coin ada di group
		save_data["coin"].append(
			{"name": coin.name}
		)
	
	# Gather player data
	save_data["hero"]["position"] = currentStage.get_node("Hero").global_position
	save_data["hero"]["health"] = currentStage.get_node("Hero").health  # Assuming player has a "health" property
	save_data["hero"]["koin"] = currentStage.get_node("Hero").koin  # Assuming player has a "score" property

	# Save data to a file
	var saveFile = File.new()
	saveFile.open(saveCheckPointPath, File.WRITE)
	saveFile.store_var(save_data)
	saveFile.close()
	print(JSON.print(save_data)) 

func load_game_state(currentStage):
	# get nama nodes agar bisa di loop dengan cara mendapatkan child dari node parent
	var groupEnemy = currentStage.get_node('GroupMusuh').get_children()
	var groupCoin = currentStage.get_node('TempatKoin').get_children()
	var hero = currentStage.get_node('Hero')
	# load file save
	var file = File.new()
	# jika savean ada, maka
	if file.file_exists(saveCheckPointPath):
		# open savean
		file.open(saveCheckPointPath, File.READ)
		# load data dict
		var saveData = file.get_var()
		# file di close karena sudah tidak dipakai
		file.close()
		# check stage berapa? apakah sama dengan save savean
		# jika sama, maka stage akan di load dari save2an
		if saveData['stage'] == currentStage.stageNow:
			# load untuk player
				# position, health, score
			hero.koin = saveData['hero']['koin']
			hero.health = saveData['hero']['health']
			hero.position = saveData['hero']['position']
			# update gui koin & Health
			hero.loadGuiHero()
			# loop untuk semua musuh di stage sekarang
			for enemy in groupEnemy:
				# musuh default akan di destroy / hapus
				var enemyFind =  false;
				# jika di save musuh tidak ada, berarti musuh di stage sudah di bunuh
				# yang mana artinya, ketika reload, musuh di stage harus di hapus
				for enemy_save in saveData['enemy']: 
					if enemy_save['name'] == enemy.name:
						 enemyFind = true;
				if enemyFind == false:
					enemy.hapus()
			
			for coin in groupCoin:
				# coin default akan di destroy / hapus
				var coinFind =  false;
				
				# jika di save coin tidak ada, berarti coin di stage sudah di bunuh
				# yang mana artinya, ketika reload, coin di stage harus di hapus
				for coin_save in saveData['coin']: 
					if coin_save['name'] == coin.name:
						 coinFind = true;
				if coinFind == false:
					coin.hapus()
			
		# jika tidak sama, ada kemungkinan stage sekarang sudah stage yg baru, tapi save2an masih di stage sebelumnya
		else:
			# hapus check point
			delete_checkpoint()
			# do nothing aja
	# jika savean tidak ada, maka
	else:
		print("No save game found.")

func delete_checkpoint():
#	var file = File.new()
#	file.remove(saveCheckPointPath)
	var dir = Directory.new()
	if dir.file_exists(saveCheckPointPath):
		dir.remove(saveCheckPointPath)
	
