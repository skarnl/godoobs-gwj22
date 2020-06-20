# This file contains logic to keep track of what NPCs are following you in your
# ratvolution

extends Node

signal followers_changed

var _followers = []

func add_follower(follower_id: String) -> void:
	_followers.append(follower_id)
	
	emit_signal('followers_changed', _followers)


func get_followers() -> Array:
	return _followers

# reset the followers progress - in case of going back to the menu / game-over
func reset() -> void:
	_followers = []

	# TODO: do we need to emit the signal the followers changed? probably not
