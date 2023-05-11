class Settlement
  attr_reader :name, :description, :shops, :board

  def initialize(plot)
    @name        = set_name()
    @description = set_description()
    @shops       = set_shops()
    @board       = set_board(plot)
  end

  private

  def set_name()
    # Total 74 Prefixes
    prefix = ["Angel", "Autumn", "Basin", "Black", "Brine", "Bronze", "Cave", "Clay", "Cloud", "Cold", "Crag", "Crow", "Crystal", "Curse", "Dead", "Dire", "Dirt", "Dry", "Dusk", "Edge", "Elder", "Ever", "Fall", "Far", "Flat", "Gloom", "Gold", "Grass", "Green", "Hazel", "Hound", "Iron", "Knight", "Lake", "Light", "Lost", "Mad", "Mage", "Maple", "Mid", "Mill", "Mist", "Moon", "Mud", "Mute", "Never", "Ocean", "Pearl", "Pine", "Pond", "Raven", "Rock", "Rogue", "Rose", "Shade", "Silent", "Sleek", "Sly", "Small", "Snow", "South", "Stag", "Star", "Steam", "Steel", "Steep", "Stone", "Summer", "Swamp", "Thorn", "Timber", "Trade", "West", "Wind"]
    # Total 70 adjes
    adj = ["band", "barrow", "bay", "bell", "borough", "brook", "burgh", "burn", "cairn", "call", "chill", "cliff", "crest", "dale", "denn", "drift", "fell", "ford", "forest", "fort", "front", "frost", "garde", "glen", "grave", "guard", "gulch", "hallow", "ham", "haven", "helm", "hill", "hold", "holde", "keep", "land", "light", "maw", "mere", "minster", "mire", "mond", "moor", "mount", "mouth", "pass", "pond", "post", "rest", "shade", "shield", "shire", "shore", "spell", "stall", "star", "summit", "valley", "vault", "vein", "view", "ville", "wall", "wallow", "ward", "water", "well", "wharf", "wind", "wood"]
    return "#{prefix[rand(74)]}#{adj[rand(70)]}"
  end # set_name()

  def set_description()
    return "You enter the village and are greeted by its #{%w{wooden stone brick}[rand(3)]} buildings."
  end #set_description()

  def set_shops()
    shops = Hash.new
    %{general magic tavern temple weapons}.each do |type|
      shops[type] = Shop.new(type)
    end
    return shops
  end # set_shops()

  def set_board(plot)
    board = []
    #
  end # set_board()

end
