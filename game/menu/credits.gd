extends Panel

var names = [
	'Indrek\nwriting\n[url]https://indrek.itch.io/[/url]',
	'Oskar\nlead developer\n[url]https://skarnl.itch.io/[/url]',
	'Janiform\nPixel Artist\n[url]https://janiform.itch.io/[/url]',
	'Quill\nanimator/artist\n[url]https://quillington.itch.io/[/url]',
	'Katarsis Studio\nSound\n[url]https://katarsis.itch.io/[/url]',
	'Randomcode\ndeveloper\n'
]


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


func _randomize_names():
	randomize()
	
	var random_order = names.duplicate()
	random_order.shuffle()
	
	var random_order_1 = random_order.slice(0, 2)
	var random_order_2 = random_order.slice(3, random_order.size() - 1)
	
	$credits_text.bbcode_text = ''
	$credits_text2.bbcode_text = ''
	
	for name in random_order_1:
		$credits_text.append_bbcode("%s \n\n" % name)

	for name2 in random_order_2:
		$credits_text2.append_bbcode("%s \n\n" % name2)


func show_credits():
	_randomize_names()
	show()
	$AnimationPlayer.play("show_text")
