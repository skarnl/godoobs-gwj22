extends Node

var dic : Dictionary = {}

func play_foley(audio_clip : AudioStream, priority : int = 0):
	for child in $Foley.get_children():
		if child.playing == false:
			child.stream = audio_clip
			child.play()
			dic[child.name] = priority
			break
		if child.get_index() == $Foley.get_child_count() - 1:
			var priority_player = check_priority(dic, priority)
			if priority_player != null:
				$Foley.get_node(priority_player).stream = audio_clip
				$Foley.get_node(priority_player).play()
				dic[priority_player] = priority
	pass
	
func check_priority(_dic : Dictionary, _priority):
	var prio_list : Array = []
	
	for key in _dic:
		if _priority > _dic[key]:
			prio_list.append(key)
	
	var last_prio = null
	for key in prio_list:
		if last_prio == null:
			last_prio = key
			continue
		if _dic[key] < _dic[last_prio]:
			last_prio = key
	return last_prio
	pass

func play_music(music_clip : AudioStream):
	$Music/Music_Player.stream = music_clip
	$Music/Music_Player.play()
