extends Button

var music_bus = AudioServer.get_bus_index("Music")

func _on_TombolVolumeLevel1_pressed():
	AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))


func _on_TombolVolume_pressed():
	AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))


func _on_TombolVolumeLevel2_pressed():
	AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))


func _on_TombolVolumeLevel3_pressed():
	AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))
