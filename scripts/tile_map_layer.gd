extends TileMapLayer

var noise = FastNoiseLite.new()
var main_atlas_id = 0

const TILE_MAPPING: Dictionary = {
	"water_low": { "tile": Vector2(0, 0), "rarity": 1.0 },
	"water_high": { "tile": Vector2(0, 1), "rarity": 1.0 },
	"land_low": { "tile": Vector2(1, 0), "rarity": 1.0 },
	"land_high": { "tile": Vector2(1, 1), "rarity": 1.0 },
	"forest_low": { "tile": Vector2(2, 0), "rarity": 1.0 },
	"forest_high": { "tile": Vector2(2, 1), "rarity": 1.0 },
	"iron_low": { "tile": Vector2(3, 0), "rarity": 0.5 },
	"iron_high": { "tile": Vector2(3, 1), "rarity": 0.5 },
	"copper_low": { "tile": Vector2(4, 0), "rarity": 0.3 },
	"copper_high": { "tile": Vector2(4, 1), "rarity": 0.3 },
	"stone_low": { "tile": Vector2(5, 0), "rarity": 0.2 },
	"stone_high": { "tile": Vector2(5, 1), "rarity": 0.2 },
	"coal_low": { "tile": Vector2(6, 0), "rarity": 0.3 },
	"coal_high": { "tile": Vector2(6, 1), "rarity": 0.3 },
	"uranium_low": { "tile": Vector2(7, 0), "rarity": 0.1 },
	"uranium_high": { "tile": Vector2(7, 1), "rarity": 0.1 },
	"oil_low": { "tile": Vector2(8, 0), "rarity": 0.1 },
	"oil_high": { "tile": Vector2(8, 1), "rarity": 0.1 },
}

func _ready() -> void:
	# Configure FastNoiseLite settings
	noise.seed = randi()  # Random seed for varied noise
	#noise.noise_type = FastNoiseLite.NOISE_OPENSIMPLEX2  # Example noise type
	noise.fractal_type = FastNoiseLite.FRACTAL_FBM
	noise.fractal_octaves = randf_range(1,10)
	noise.frequency = 0.05

	var world_place = Vector2(0, 0)
	for x in range(100):
		for y in range(100):
			var pos = Vector2(x, y) + world_place
			var value = noise.get_noise_2d(pos.x, pos.y)
			var tile_index = _get_tile_from_noise(value)
			set_cell(pos, 0, tile_index)

func _apply_rarity(tile_key: String) -> Vector2:
	var rarity = TILE_MAPPING[tile_key]["rarity"]
	if randf() <= rarity:
		return TILE_MAPPING[tile_key]["tile"]
	else:
		var tileList = [TILE_MAPPING["land_low"]["tile"], TILE_MAPPING["land_high"]["tile"]]
		return tileList[randi_range(0,1)]
		
			
func _get_tile_from_noise(value: float) -> Vector2:
	# print("Noise Value: ", value)
	# Map noise values to tile coordinates
	if value < -0.8:
		return _apply_rarity("water_low")
	elif value < -0.7:
		return _apply_rarity("water_high")
	elif value < -0.6:
		return _apply_rarity("land_low")
	elif value < -0.5:
		return _apply_rarity("water_high")
	elif value < -0.4:
		return _apply_rarity("forest_low")
	elif value < -0.3:
		return _apply_rarity("forest_high")
	elif value < -0.2:
		return _apply_rarity("iron_low")
	elif value < -0.1:
		return _apply_rarity("iron_high")
	elif value < 0.0:
		return _apply_rarity("copper_low")
	elif value < 0.1:
		return _apply_rarity("copper_high")
	elif value < 0.2:
		return _apply_rarity("stone_low")
	elif value < 0.3:
		return _apply_rarity("stone_high")
	elif value < 0.4:
		return _apply_rarity("coal_low")
	elif value < 0.5:
		return _apply_rarity("coal_high")
	elif value < 0.6:
		return _apply_rarity("uranium_low")
	elif value < 0.7:
		return _apply_rarity("uranium_high")
	elif value < 0.8:
		return _apply_rarity("oil_low")
	else:
		return _apply_rarity("oil_high")
