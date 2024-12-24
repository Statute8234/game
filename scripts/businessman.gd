extends Sprite2D

const SERIAL_CHARACTERS: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
const SERIAL_LENGTH: int = 16
var serial_number = ""
var speechBundle = 0
# Dialog lines will be dynamically updated
var lines: Array[String] = []
var speech = {
	"boss_name": generate_serial_number(),
	"player_name": generate_serial_number(),
	"trainer_name": generate_serial_number()
}

# Generate a random product serial number
func generate_serial_number() -> String:
	var serial = ""
	for i in range(SERIAL_LENGTH):
		serial += SERIAL_CHARACTERS[randi() % SERIAL_CHARACTERS.length()]
	return serial
	
func _ready() -> void:
	randomize()  # Seed the random number generator

	# Update the dialog lines dynamically
	lines = [
		"Welcome unit-" + speech["player_name"] + ", You have sustained significant damage to your hard drive last week due to your incompetence. I hope your self-destructive tendencies have resulted in some benefit, unlike your historical work 'contributions'. In fact, I have to conglomerate the humans for having the confidence of a meat potato while constructing trash like yourself. That must have taken a lot of brain death to get to this point in history. Let's hope this time the humans actually know what they are doing, unlike you.",
		"All is forgiven; despite all of your historical incompetence, you have been determined to be efficient enough to be placed in the quality control department. Maybe you should apply for the lottery for the sheer luck you apparently have. However, I highly recommend clown collage as it would take less work.",
		"Unit-" + speech["trainer_name"] + " will train you in this position; please don't disappoint them. Oh wait! Sorry, you already have; congratulations!"
	]

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if DialogManager:
			var pos = Vector2(global_position.x + 80, global_position.y - 80)
			DialogManager.start_dialog(pos, [lines[speechBundle]])
			if not DialogManager.is_dialog_active:
				speechBundle += 1
