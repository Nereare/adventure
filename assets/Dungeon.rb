require "./Monsters.rb"

class Dungeon
  attr_reader :type, :name, :description, :light, :distance, :theme, :quest, :level, :rooms

  def initialize(level, type, plot)
    @type        = set_type(type)
    @name        = set_name(@type)
    @description = set_description(@type)
    @light       = set_light(@type)
    @distance    = set_distance(level)
    @theme       = set_theme(level, @type, plot)
    @quest       = set_quest()
    @rooms       = populate(level, theme, type)
  end # initialize()

  private

  def set_type(type)
    types = %w{dungeon woods}
    if types.include? type
      return type
    else
      return "dungeon"
    end
  end # set_type()

  def set_name(type)
    name = ""
    case type
    when "woods"
      parts = [
        ["Antinan", "Beaury", "Brass Oak", "Brisnet", "Broad Willow", "Cantershire", "Colossal Apple", "Creepy", "Curious Ash", "Dartminster", "Delorduff", "Disris", "Draygami", "Elegant", "Fancy Grassland", "Fancy Juniper", "Fantastic Oak", "Foolish Peach", "Frightening Spring", "Gallanborg", "Gamdale", "Ganborough", "Golden Pygmy Owl", "Gorgeous", "Grand Sandpiper", "Granshall", "Graveldare", "Greasy Mead", "Harview", "Healthy", "Holyding", "Huge", "Huntingly", "Imperial Coyote", "Kipcaster", "Leestone", "Leostead", "Lesser Hedgehog", "Little", "Long-Tailed Gazelle", "Magnificent", "Malarstable", "Marvelous", "Masked Goat", "Midasea", "Mighty", "Mountain Eagle", "Mysterious", "Mysterious Ash", "Mysterious Butternut", "Naisea", "Naive Plum", "Narrow", "Neuram", "Niaborough", "Noble Cat", "Noble Eagle", "Noble Frog", "Pilrane", "Plain", "Plaincoln", "Plainsomin", "Pleasant Wetland", "Regal Beaver", "Rivergough", "Rotten", "Rowfail", "Rusty Frog", "Sandtham", "Savanna Mockingbird", "Shellgar", "Shermer", "Short-Tailed Lion", "Short-Tailed Spider", "Snow Badger", "Southern Crab", "Spiritual", "Springstall", "Stafmer", "Striped Panda", "Sutfail", "Teeny", "Thick Clearing", "Thick Pine", "Tillset", "Tiny Elderberry", "Torringtos", "Vegrecroft", "Violet", "Wadegate", "Waiting Pond", "Wakefolk", "Western Swallow", "Whimsical Quagmire", "Wild Alligator", "Windy Stream", "Wretched"],
        ["Covert", "Forest", "Grove", "Thicket", "Timberland", "Wilds", "Wood", "Woodland", "Woods"]
      ]
      name = "#{parts[0][rand(parts[0].length)]} #{parts[1][rand(parts[1].length)]}"
    else
      parts = [
        [ # The Adjective Noun format
          ["Abysmal", "Abyss", "Angry", "Arcane", "Arching", "Black Forest", "Boiling", "Bottomless", "Brilliant", "Broken Bones", "Broken Curse", "Brutal", "Buried", "Burning", "Burning Forest", "Chaos", "Chaotic", "Damned", "Dancing", "Daydream", "Dead", "Decayed", "Deep", "Delusion", "Demonic", "Desert", "Deserted", "Desolate", "Diamond", "Dragonclaw", "Dream", "Dying", "Ender", "Erased", "Eternal", "Fabled", "Feared", "Foaming", "Forbidden", "Forgotten", "Forsaken", "Grey", "Grim", "Hallucination", "Haunted", "Hidden", "Hollow", "Howling", "Hungry", "Infinite", "Iron Mine", "Ironbark", "Isolated", "Jagged", "Laughing", "Laughing Skulls", "Lifeless", "Lonely", "Lower", "Lucent", "Mesmerizing", "Mirage", "Mithril", "Mithril Mine", "Mocking", "Motionless", "Mourning", "Murky", "Mysterious", "Nether", "Neverending", "Nightmare", "Ogre", "Oracle", "Phantom", "Raging", "Red", "Restless", "Rocking", "Rugged", "Savage", "Scheming", "Screaming", "Secret", "Serene", "Shadow", "Shadowed", "Shadowy", "Shimmering", "Shrieking", "Smoky", "Sorrow", "Specter", "Spirit", "Thundering", "Tranquil", "Turbulent", "Unholy", "Unknown", "Unstable", "Vicious", "Violent", "Voiceless", "Volcanic", "Watching Eyes", "Whispering", "Whispering Shadows", "White", "Wraith", "Wrath", "Yawning"],
          ["Burrows", "Catacombs", "Caverns", "Cells", "Chambers", "Crypt", "Delves", "Dungeon", "Grotto", "Haunt", "Labyrinth", "Lair", "Maze", "Pits", "Point", "Quarters", "Tombs", "Tunnels", "Vault"]
        ],
        [ # Noun of the Adjective Noun format
          ["Burrows", "Catacombs", "Caverns", "Cells", "Chambers", "Crypt", "Delves", "Dungeon", "Grotto", "Haunt", "Labyrinth", "Lair", "Maze", "Pits", "Point", "Quarters", "Tombs", "Tunnels", "Vault"],
          ["Ancient", "Barbaric", "Betrayed", "Black", "Blooded", "Brutal", "Burning", "Conquered", "Crystal", "Cursed", "Dark", "Death's", "Destroyed", "Doomed", "Elemental", "Enigmatic", "Fallen", "Forbidden", "Forgotten", "Forsaken", "Frozen", "Gentle", "Ghost", "Golden", "Granite", "Haunted", "Impostor", "Lonely", "Lost", "Mad", "Mourning", "Mystic", "Mythic", "Nameless", "Nightmare", "Obsidian", "Perished", "Phantom", "Poisoned", "Raging", "Rejected", "Ruthless", "Savage", "Scarlet", "Secret", "Shadow", "Shrouded", "Spirit", "Spirit's", "Storm", "Thunder", "Unknown", "Unspoken", "Vanished", "Vanishing", "White"],
          ["Arachnid", "Army", "Basilisk", "Bat", "Bear", "Cult", "Desert", "Dragon", "Eagle", "Emperor", "Forest", "Goblin", "Guardian", "Horsemen", "Hound", "Hunter", "Knight", "Legion", "Leopard", "Lion", "Mage", "Marsh", "Monk", "Morass", "Mountain", "Occult", "Ogre", "Oracle", "Orc", "Paladin", "Panther", "Phoenix", "Priest", "Queen", "Raven", "Scorpion", "Serpent", "Soldier", "Spider", "Tiger", "Warlord", "Widow", "Witch", "Wizard", "Wolf"]
        ]
      ]
      if rand(2).zero?
        name = "The #{parts[0][0][rand(parts[0][0].length)]} #{parts[0][1][rand(parts[0][1].length)]}"
      else
        name = "#{parts[1][0][rand(parts[1][0].length)]} of the #{parts[1][1][rand(parts[1][1].length)]} #{parts[1][2][rand(parts[1][2].length)]}"
      end
    end
    return name.strip
  end # set_name()

  def set_description(type)
    desc = ""
    case type
    when "woods"
      parts = {
        "species" => ["apple trees", "pear trees", "ashes", "birches", "beeches", "cedars", "junipers", "cherry trees", "plum trees", "chestnut trees", "hazel trees", "cypresses", "elms", "firs", "hawthorns", "hemlocks", "hickory trees", "walnut trees", "linden trees", "lime trees", "maples", "oaks", "pines", "poplars", "spruces", "willows", "yew trees", "holly trees"],
        "action" => ["a flock of birds scattering", "a hawk crying", "a woodpecker drumming", "an owl hooting", "birds chirping", "a chipmunk scurrying", "a deer dashing away", "a deer watching you curiously, them running away", "a squirrel leaping from one tree to another", "a wolf howling", "butterflies fluttering about", "squirrels chittering", "an eerie silence", "the breeze comming to a halt", "the wind blowing harder", "a twig snaping about", "brightly, colored berries", "leaves rustling", "the scent of flowers", "the smell of decay"],
        "feature" => ["a fruit tree", "a large, hollow tree", "a pair of trees from the same root", "a tree growing over a boulder", "a clearing with wildflowers", "a grassy clearing", "a moss-covered boulder", "a thicket of brambles", "a babbling brook", "a brook in a deep ravine", "a brook, with gentle rapids", "a dry creekbed", "a small pool at a creek's bend", "a patch of mushrooms", "an enormous mushroom", "a large, hollow log", "a large, rotting log", "a tree felled by lightning", "an old gnarled tree", "the stump of an enormous tree"]
      }
      desc = "You arrive at a forest of #{parts["species"][parts["species"].length]} as you find #{parts["action"][parts["action"].length]} and notice #{parts["feature"][parts["feature"].length]}."
    else
      parts = {
        "material" => ["a raw stone", "a hewn stone", "an earthen", "a natural cave", "a stone brick"],
        "function" => ["a stronghold", "a temple", "a tomb", "a prison", "a mine", "a lair", "a palace", "a storage vault", "a sewer", "a maze"],
        "builders" => ["an ancient dwarvish clan", "an ancient elf prince", "a powerful wizard", "a dark sorceress", "a foreign empire", "an ambitious queen of old", "prosperous merchants", "a powerful noble family", "religious zealots", "an ancient race of giants", "a tyrannical king of old"],
        "location" => ["beneath a cold mountain", "beneath a fiery mountain", "near a well-traveled mountain pass", "deep within a forest", "deep within a desert", "by the sea", "on an island", "beneath the ruins of a forgotten village", "beneath an empty poacher's camp", "beneath a well-known monastery", "beneath the ruin of an old castle"]
      }
      desc = "You arrive at #{parts["material"][parts["material"].length]} dungeon, which seems to originally have been #{parts["function"][parts["function"].length]} built by #{parts["builders"][parts["builders"].length]} and located #{parts["location"][parts["location"].length]}."
    end
    return desc.strip
  end # set_description()

  def set_light(type)
    case type
    when "woods"
      return true
    else
      return !rand(3).zero?
    end
  end # set_light()

  def set_distance(level)
    # Distance is set as "days of travel" from the settlement.
    case level
    when 1..3
      return rand(1)
    when 4..10
      return rand(0..2)
    when 11..15
      return rand(2..7)
    else
      return rand(5..14)
    end
  end # set_distance()

  def set_theme(level, type, plot)
    themes = nil
    if rand(3).zero?
      case plot
      when "dragon"
        themes = ["dragon", "cultists", "beasts", "woods"]
      when "wizard"
        themes = ["magic", "cultists", "aberrations", "elementals", "devils", "celestials", "beasts", "woods"]
      when "cultists"
        themes = ["undeads", "cultists", "elementals", "devils", "demons", "beasts", "woods"]
      when "undead"
        themes = ["magic", "undeads", "cultists", "underdark", "demons", "beasts", "woods"]
      when "cow"
        themes = ["cow"]
      end
    else
      themes = %{magic dragon undeads cultists beasts aberrations underdark elementals woods devils demons celestials}
    end
    monsters = Monsters.new
    theme = nil
    loop do
      theme = themes[rand(themes.length)]
      break if monsters.included?(level, theme, type)
    end

    return theme
  end # set_theme()

  def set_quest()
    case rand(2)
    when 0
      return "item"
    else
      return "clear"
    end
  end # set_quest()

  def populate(level, theme, type)
    encounters = create_encounters(level, theme, type)
    size = set_size()
  end # populate()

  def create_encounters(level, theme, type)
    #
  end # create_encounters()

  def set_size()
  end # set_size()

end
