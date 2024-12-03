extends Node

# create array of combinations / connections
var words = [
	{"word": "Solar", "category": "Renewable Energy"},
	{"word": "Wind", "category": "Renewable Energy"},
	{"word": "Hydropower", "category": "Renewable Energy"},
	{"word": "Geothermal", "category": "Renewable Energy"},
	{"word": "Carbon Dioxide", "category": "Greenhouse Gas"},
	{"word": "Methane", "category": "Greenhouse Gas"},
	{"word": "Nitrous Oxide", "category": "Greenhouse Gas"},
	{"word": "Water Vapor", "category": "Greenhouse Gas"},
	{"word": "Coal", "category": "Fossil Fuel"},
	{"word": "Oil", "category": "Fossil Fuel"},
	{"word": "Natural Gas", "category": "Fossil Fuel"},
	{"word": "Fracking", "category": "Fossil Fuel"},
	{"word": "Plastic", "category": "Pollution"},
	{"word": "Carbon Footprint", "category": "Pollution"},
	{"word": "Deforestation", "category": "Pollution"},
	{"word": "E-waste", "category": "Pollution"}
]

# Creating Button Scene.
var word_tile_scene = ResourceLoader.load("res://word_tile.tscn")
# create an array for selected words
var selected_words = []

# main function to start the game
func _ready():
	print(words.size())
	generate_word_tiles()

# show word tile(s)
func generate_word_tiles():
	var grid_size = 4 # 4 words on a row
	# loop through 'words' and show each as a tile.
	for i in range(words.size()):
		var tile_instance = word_tile_scene.instantiate()
		# add tile to Main Scene
		add_child(tile_instance)

		# Position and set word
		#tile_instance.position = Vector2((i % grid_size) * 220, (i / grid_size) * 60)
		tile_instance.text = words[i]["word"]

		# Connect button signal to track selected words
		var callable_with_binds = Callable(self, "_on_tile_pressed").bind(tile_instance, words[i])
		tile_instance.connect("pressed", callable_with_binds)

func _on_tile_pressed(tile, word_data):
	# Toggle selection
	tile.is_selected = !tile.is_selected
	tile.update_visual()

	# Add or remove from selected words
	track_selected(tile, word_data)

	# Check if the required number of selections are made
	if selected_words.size() == 4:  # Adjust based on your logic for validation
		check_groups()

func track_selected(tile, word_data):
	if tile.has_method("is_selected") and tile.is_selected:
		if not selected_words.has(word_data):  # Avoid duplicates
			selected_words.append(word_data)
		else:
			selected_words.erase(word_data)
	#elif tile.has_method("is_selected"):
		#selected_words.erase(word_data)
	print("Selected words:", selected_words)
	
func check_groups():
	var grouped = {}
	for word_data in selected_words:
		var category = word_data["category"]
		if category not in grouped:
			grouped[category] = []
		grouped[category].append(word_data["word"])

	# Check if all groups are valid
	var all_groups_valid = true
	for category in grouped.keys():
		if grouped[category].size() != 4:  # Ensure exact group size match
			all_groups_valid = false
			break
	
	if all_groups_valid:
		print("All groups valid!")
		advance_storyline()
	else:
		print("Invalid groupings. Try again.")

func advance_storyline():
	
	print("Storyline advanced!")
