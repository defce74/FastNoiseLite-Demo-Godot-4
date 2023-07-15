# map_data.gd
#---------------------------------
class_name map_data extends Resource

#---------------------------------
# tiles
@export var m_layers: int # number of layers
@export var m_mapSize: Vector2 # map dimensions (width, height)

# noise @export variables (default values)
@export var m_noiseType: FastNoiseLite.NoiseType
@export var m_seed: int
@export var m_freq: float

# fractal @export variables (default values)
@export var m_fractalType: FastNoiseLite.FractalType
@export var m_fractalOctaves: int
@export var m_fractalLacunarity: float
@export var m_fractalGain: float
@export var m_fractalWeightedStrength: float 
@export var m_fractalPingPongStrength: float

# cellular @export variables (default values)
@export var m_cellularReturnType: FastNoiseLite.CellularReturnType
@export var m_cellularDistanceFunction: FastNoiseLite.CellularDistanceFunction
@export var m_cellularJitter: float

# domain warp @export variables (default values)
@export var m_domainWarpEnabled: bool
@export var m_domainType: FastNoiseLite.DomainWarpType
@export var m_domainAmplitude: float
@export var m_domainFrequency: float
@export var m_domainFractalType: FastNoiseLite.DomainWarpFractalType
@export var m_domainFractalOctaves: int
@export var m_domainFractalGain: float
@export var m_domainFractalLacunarity: float

#---------------------------------
func set_mapSize(size: int):
	m_mapSize.x = size
	m_mapSize.y = size



