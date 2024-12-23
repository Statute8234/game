extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var timer = $LetterDisplayTimer

const MAX_WIDTH = 256

var text = ""
var letter_index = 0
var letter_time = 0.03
var space_time = 0.06  # Changed from 0
var punctuation_time = 0.2

signal finished_displaying

func display_text(text_to_display: String):
	text = text_to_display
	label.text = ""
	letter_index = 0
	
	print("Starting to display text: ", text_to_display)  # Debug print
	
	custom_minimum_size.x = min(label.size.x, MAX_WIDTH)
	if label.size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await get_tree().process_frame
		custom_minimum_size.y = label.size.y
	
	global_position.x -= label.size.x * 2
	global_position.y -= label.size.y * 4
	
	display_letter()

func display_letter():
	if letter_index >= text.length():
		print("Finished displaying text")  # Debug print
		finished_displaying.emit()
		return
		
	for letter in text:
		label.text += text[letter_index]
		print("Displaying letter: ", text[letter_index]) 
		var current_char = text[letter_index]
		var delay = letter_time
		
		match current_char:
			"!", ".", "?", ",":
				delay = punctuation_time
			" ":
				delay = space_time
			_:
				delay = letter_time
		
		letter_index += 1
		
		print("Starting timer with delay: ", delay)  # Debug print
		timer.start(delay)

func _on_letter_display_timer_timeout():
	print("Timer timeout")  # Debug print
	display_letter()
