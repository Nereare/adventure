class Shop
  attr_reader :name, :type, :description, :owner, :stock_rate, :stock_fix
  attr_reader :stock_rand, :stock_rand_qtt, :buy_rate, :buy, :limits

  def initialize(type)
    @name           = set_name(type)
    @type           = type
    @description    = set_description(type)
    @owner          = create_owner(type)
    @stock_rate     = set_rate("sell")
    @buy_rate       = set_rate("buy")
    @stock_fix      = set_fix_stock(type, @stock_rate)
    @stock_rand     = set_rand_stock(type, @stock_rate)
    @stock_rand_qtt = set_rand_stock_qtt(type)
    @buy            = set_buys(type)
    @limits         = set_limits(type)
  end # initialize()

  private

  def set_name(type)
    names = {
      "general" => {
        prefix: [],
        adj: ["A New View", "About Time", "Age of Vintage", "Aged Goodness", "Anecdotes", "Another Man's Treasures", "Another's Treasures", "Antique Cache", "Antique Cuties", "Antique Hut", "Antique Trove", "Antiquities", "Authentic Antiquities", "Beautiful Salvage", "Blasts from the Past", "Bygones", "Checkered Pasts", "Cozy Collectibles", "Dinky and Dainty", "Discoveries", "Drab to Fab", "Echoes of the Past", "Established Goods", "Focus of the Past", "Focus on the Past", "Forget Me Nots", "Forgotten Furnishings", "From Oblivion", "From Time Immemorial", "Frozen in Time", "General Goods", "Good As New", "Good Ol' Days", "Hodge Podge Lodge", "Honest Heirlooms", "In-Of-Date", "Joys For Forever", "Junk Deluxe", "Knick-knack Paddywhack Shack", "Little Collectibles", "Living Memories", "Long Time No See", "Lost and Found in Time", "Matters of Time", "Memory Lane", "Miracles of the Past", "Mod Life", "Modern Memories", "Modern Vintage", "Odd Types", "Old and Bold", "Old Gold", "Old Roots", "Oldies and Goldies", "One Time or Another", "Out of the Attic", "Pandora's Box", "Paragon Prizes", "Pass On the Past", "Past Caring", "Past Meets Present", "Pockets of Time", "Precious Past", "Precious Things", "Presents for the Present", "Preserved", "Primes of the Past", "Rags and Riches", "Recent Memories", "Recollect Them All", "Recollectibles", "Reliquary", "Remains to be Seen", "Remember", "Renewed Life", "Renewed Memories", "Retro Relics", "Revered Relics", "Revival", "Salvage Garden", "Secrets of the Past", "Shared Memories", "Stuff and Things", "Sweet Memories", "Tales of the Past", "Tales Resold", "Tales Retold", "The Antique Market", "The Salvage Beast", "The Time is Ripe", "The Treasure Trove", "Things Past", "Thingymabobs", "Time Honored", "Time Not Forgotten", "Time Recovered", "Timeless Treasures", "Timeless Trinkets", "Times Remembered", "Twosided", "Utter Clutter", "Vestiges of the Past", "Vintage", "Vintage Baby", "Warm Wares", "Wayward Wealths", "Well of a Time", "Whispers of the Past", "Wonders of the Past"],
        suffix: []
      },
      "magic" => {
        prefix: ["The Adorable", "The Amusing", "The Angry", "The Arcane", "The Awesome", "The Awkward", "The Baby", "The Banished", "The Bathing", "The Bigger", "The Bitter", "The Bleeding", "The Blind", "The Blissful", "The Bound", "The Bright", "The Brilliant", "The Broken", "The Champion's", "The Clean", "The Clever", "The Cone", "The Dancing", "The Dark", "The Dizzy", "The Dragon", "The Ebon", "The Fancy", "The Fantastic", "The Fel", "The Gentle", "The Glass", "The Glowing", "The Golden", "The Green", "The Grumpy", "The Heavy", "The Invisible", "The Last", "The Living", "The Lucky", "The Minotaur", "The Ninth", "The Old", "The Pestle", "The Philosopher's", "The Phony", "The Plain", "The Quiet", "The Raven's", "The Ring", "The Serene", "The Silver", "The Small", "The Sneaky", "The Steel", "The Storm", "The Summoned", "The Third", "The Thunder", "The Tinkered", "The Triton's", "The Twinkle", "The Unicorn's", "The Wand's", "The Wicked"],
        adj: ["Artifact", "Aspect", "Banshee", "Beacon", "Beast", "Bigfoot", "Blizzard", "Book", "Boots", "Bunyip", "Centaur", "Chupacabra", "Cockatrice", "Cupid", "Cyclops", "Dryad", "Elemental", "Elf", "Feathered Serpent", "Focus", "Gargoyle", "Goods", "Harpy", "Hippocampus", "Hippogriff", "Hobgoblin", "Horn", "Hourglass", "Human", "Hydra", "Imp", "Infinity", "Lead", "Life", "Manticore", "Marker", "Maze", "Message", "Nymph", "of Cold", "of Life", "Ogre", "Pegasus", "Quill", "Ring", "Robe", "Rune", "Sasquatch", "Scroll", "Seal", "Shapeshifter", "Siren", "Skull", "Spell", "Sphere", "Star", "Statue", "Steed", "Stone", "Tiara", "Tome", "Trident", "Troll", "Unicorn", "Vampire", "Vial", "Want", "Werewolf", "Wish", "World Turtle", "Wraith"],
        suffix: []
      },
      "tavern" => {
        prefix: ["The Abstract", "The Adorable", "The Anxious", "The Armed", "The Asian", "The Australian", "The Awesome", "The Awful", "The Beautiful", "The Bitter", "The Bloody", "The Blushing", "The Bored", "The Cheap", "The Closed", "The Cunning", "The Daily", "The Dapper", "The Defiant", "The Deserted", "The Devilish", "The Dirty", "The Dry", "The Dwarvish", "The Educated", "The Entertaining", "The Even", "The Faint", "The First", "The Frozen", "The Full", "The Fuzzy", "The Gigantic", "The Glistening", "The Gray", "The Grumpy", "The Happy", "The Hissing", "The Hollow", "The Hot", "The Hypnotic", "The Interesting", "The International", "The Jewish", "The Kaput", "The Known", "The Lazy", "The Lethal", "The Limping", "The Long", "The Massive", "The Mean", "The Metal", "The Middle", "The Misty", "The Mixed", "The Naive", "The Narrow", "The Nasty", "The National", "The Natural", "The Obedient", "The Oceanic", "The Pathetic", "The Psychotic", "The Puny", "The Puzzling", "The Rabid", "The Rapid", "The Relieved", "The Right", "The Round", "The Royal", "The Scared", "The Scattered", "The Shaggy", "The Shaking", "The Short", "The Shouting", "The Sick", "The Sleeping", "The Snobbish", "The Soft", "The Square", "The Steel", "The Superb", "The Supreme", "The Tasty", "The Terrible", "The Thin", "The Thundering", "The Tired", "The Triangular", "The Ugliest", "The Unusual", "The Venomous", "The Violent", "The Voiceless", "The Waiting", "The Well-Groomed", "The Wicked", "The Windy", "The Wretched", "The Wrong", "Ye Olde"],
        adj: ["Accordion", "Ant", "Anteater", "Ape", "Apple", "Bamboo", "Bass", "Beaver", "Birds", "Bone", "Bongo", "Book", "Branch", "Bunny", "Butterflies", "Chainmail", "Cherry", "Chicken", "Cloth", "Cookie", "Couple", "Crew", "Crocodile", "Crossbow", "Crow", "Crows", "Cushion", "Dark Elf", "Doves", "Dwarf", "Eagle", "Eel", "Elephant", "Fiddle", "Flame", "Flea", "Fly", "Gazelle", "Gentlewomen", "Giant", "Goat", "Gooseberry", "Gopher", "Gorilla", "Grotto", "Hag", "Hammer", "Hamsters", "Hill", "Hippo", "Horn", "Husband", "Ice", "Kangaroo", "Kiwi", "Knight", "Lamp", "Lavender", "Leg", "Lions", "Lobster", "Loch", "Lyre", "Mandolin", "Mango", "Meat", "Midget", "Mouse", "Nugget", "Nut", "Octopus", "Owl", "Pie", "Pike", "Pirate", "Plate", "Pony", "Queen", "Rhino", "Rhinoceros", "Rope", "Rose", "Salt", "Shipmate", "Skies", "Skull", "Snail", "Snakes", "Snowball", "Stars", "Steed", "Stone", "Swan", "Table", "Tankard", "Tigers", "Traveler", "Tree", "Triangle", "Trombone", "Tuba", "Tusk", "Willow", "Wood Elf", "Yew"],
        suffix: ["Pub", "Pub", "Pub", "Pub", "Tavern", "Tavern", "Tavern", "Tavern", "Inn", "Inn", "Inn", "Bar", "Bar", "Bar", "", "", "", "", "", ""]
      },
      "temple" => {
        prefix: ["Altar Of", "Cathedral Of", "Chapel Of", "Church Of", "House Of", "Monastery Of", "Mosque Of", "Pagoda Of", "Pantheon Of", "Sanctuary Of", "Sanctum Of", "Shrine Of", "Synagogue Of", "Temple Of"],
        adj: ["Agony", "Allegiance", "Amnesia", "Azuth", "Bane", "Bliss", "Chaos", "Chauntea", "Clairvoyance", "Confidence", "Cyric", "Decay", "Dedication", "Determination", "Dreams", "Edos", "Eternity", "Exile", "Fate", "Felicity", "Fire", "Gond", "Grief", "Helm", "Humility", "Ilmater", "Insight", "Integrity", "Kelemvor", "Kinship", "Knowledge", "Kossuth", "Lament", "Lathander", "Life", "Lolth", "Lore", "Loss", "Malar", "Mask", "Mielikki", "Mystra", "Oghma", "Order", "Probabilities", "Purpose", "Pursuit", "Quests", "Repose", "Resolutions", "Reverence", "Revival", "Seclusion", "Secrets", "Selûne", "Shar", "Shaundakul", "Silence", "Silvanus", "Spirits", "Sune", "Talos", "Tempus", "Termination", "Thirst", "Time", "Torm", "Tragedy", "Tranquility", "Triumph", "Twilight", "Tymora", "Tyr", "Umberlee", "Uthgar", "Utopia", "Visions", "Water", "Waukeen", "Wisdom", "Withdrawal", "Zeal"],
        suffix: []
      },
      "weapons" => {
        prefix: [],
        adj: ["A Steel", "Adore Ore", "Anvil Crafts", "Anvil Mastery", "Anvil Works", "Anything Metal", "Ball of Fire", "Balls of Fire", "Baptisms of Fire", "Bars of Steel", "Beat the Heat", "Beats of Fire", "Belly Fires", "Between Hammer and Anvil", "Blackstone Forge", "Blazing Blacksmiths", "Blazing Glory", "Blazing Trails", "Blue Blazes", "Blue Steel", "Breathing Fire", "By Hammer and Hand", "Clamorize", "Clobbering Time", "Curious Forge", "Fire & Brimstone", "Fire It Up", "Flux Crux", "Flux Deluxe", "Forge and Fabricate", "Forge away", "Forging Ahead", "Forging Matters", "George's Forge", "Gorge 'n Forge", "Hammer Clamor", "Hammer Glamor", "Hammer Home", "Hammer It Hot", "Hammer Out", "Hammer Time", "He Who Smelt It", "Heat Up", "Heavy Metal Works", "Heavy Metals", "Hot diggety dog", "Hot diggety", "Hot Hot Hot", "Hot Iron", "Hot Rod", "Hot Spot", "Hot Stuff", "Hot-Shot", "Ingot This", "Iron Designs", "Iron Man", "Iron Woman", "Ironclad", "Matter of Metal", "Metal Accent", "Metal Arts", "Metal Expertise", "Metal Fabrications", "Metal Mania", "Metal Maniac", "Metal Mastery", "Metal Trades", "Metallurgy", "Metalworks of Art", "Mind Over Metal", "Mineral Minded", "Mr Smith", "Mrs Smith", "Nice Ring To It", "Ore Decor", "Ore Galore", "Ore Really", "Ore Restore", "Ore Store", "Phoenix Fire", "Pound World", "Real Steel", "Smelt Art", "Smelt in my Arms", "Smelt My Hearth", "Smelting Pot", "Smelts of Heaven", "Smite Thee", "Smith Thee", "Smithen", "Smitten", "Sparks and Flames", "Squeal of Steel", "Steel Arms", "Steel Fabrications", "Steel Ideal", "Steel Thunder", "Steel Wings", "Stop Hammer Time", "Sword in the Forge", "Sword in the Stone", "The Ancient Anvil", "The Blacksmith's Forge", "The Clamor Shop", "The Clank Tank", "The Fire Squire", "The Gorge Forge", "The Hot Forge", "The Hot Ticket", "The Metal Petal", "The Right Clank", "The Smelt Belt", "The Smelt Celt", "The Smithy", "The Unbreakable Anvil", "There Be Smoke", "True as Steel", "Under Construction", "While the Iron's Hot", "Young Flames"],
        suffix: []
      }
    }
    name = Hash.new(3)
    # Prefix
    if names[type][:prefix].empty?
      name[:prefix] = ""
    else
      name[:prefix] = names[type][:prefix][rand(names[type][:prefix].length.to_i)].to_s + " "
    end
    # Adjective
    if names[type][:adj].empty?
      name[:adj] = ""
    else
      name[:ajd] = names[type][:adj][rand(names[type][:adj].length)].to_s + " "
    end
    # Suffix
    if names[type][:suffix].empty?
      name[:suffix] = ""
    else
      name[:suffix] = names[type][:suffix][rand(names[type][:suffix].length)]
    end

    final_name = ""
    name.each { |key, item| final_name += item.to_s }
    return final_name.strip
  end # set_name()

  def set_description(type)
    desc = "You enter the building and find #{%w{large cozy tiny two-story}[rand(4)]} hall with a counter on the far back, behind which the owner stands #{["working hard", "arranging some items", "reading and updating the ledger", "waiting for patrons", "half-asleep"][rand(5)]}. "
    case type
    when "general"
      desc += "#{["Several", "A handful", "Few", "A plethora"][rand(4)]} of #{%w{well-kept dusty neat cluttered}[rand(4)]} shelves cover the walls between you and the counter. The items a mix of #{%w{garbage antiques doodads trash}[rand(4)]} and #{%w{trinkets adventure-gear jewels art}}."
    when "magic"
      desc += "The inside of the building is weirdly #{["much larger", "larger", "smaller"][rand(3)]} than the exterior. #{["Several", "A handful", "Few", "A plethora"][rand(4)]} of #{%w{well-kept dusty neat cluttered}[rand(4)]} shelves cover the walls between you and the counter. A variety of vials, crystals and unkown objects cover these shelves. The ceiling features #{["patterns of stars unkown to you", "a real-time replica of the outside sky", "clouds that eventually crack in thunder", "a faint glint of gold shining godrays into the room"]}."
    when "tavern"
      desc += "#{["Countless", "Several", "Many", "Some", "A few"][rand(5)]} tables are scattered around the hall, with a #{["well-kept brick", "large and rustic", "ground", "old", "dusty and half-cracked"][rand(5)]} fireplace #{["near the back", "over to the east after the tables", "to your left"][rand(3)]} #{["with a warm fire burning", "with a fire that needs some refueling", "with half-burnt coals", "unlit and cold"]}. The smell of #{["freshly baked bread", "ale and pork", "old spilt ale", "baked onions and old wine", "wood and puke", "wine and freshly cooked meats"][rand(6)]} hits your nose. The hall is #{["crowded and noisy, with parties and games clamoring one over the other", "filled with a couple of patrons, each on their table eating silently", "populated by some locals having their meals, while a weirdly classy bard plays a lute near the fireplace", "half-empty while a half-orc sings a song with the proficiency of a brainless mind-flayer", "empty except by you and the keeper"][rand(5)]}."
    when "temple"
      desc += "You are greeted by a #{%w{light holy inebriating silent somber heavy}[rand(6)]} aura and the scent of #{%w{sandalwood flower myrrh rose herbal lavender white-sage sage lemongrass amber cedar jasmine pine vanilla}[rand(14)]} incense. The hall #{["is dotted with pews for prayers", "is wide and empty, with holy patterns on the ground", "has a long nave with ailes dotted with holy figures and symbols", "features a single stone slab as altar, with a few pools of dark liquid around the aisles"][rand(4)]}. #{["Many", "A large number of", "A few", "Some", "No"][rand(5)]} attendants are present at the moment and a #{["fully-vested priest", "acolyte", "temple keeper"][rand(3)]} moves about, tending to the building."
    when "weapons"
      if rand(2).zero?
        # The shop has a forge in the building.
        desc += "The interior is hot and heavy, you hear the #{["faint sounds of a nearby forge", "loud clanks of a hammer against an anvil to you right"][rand(2)]} as new stock is being forged. The counter in the back of the room is being tended by the shopkeeper."
      else
        # The shop resells forged items, so has no forge.
        desc += "The room you enter has several #{["crates littered with weapons and armor pieces", "cabinets labeled neatly as to what contents they hold, all of them locked", "wall displays with proud weapons and armor on display", "armorstands and weaponracks with a selection of stock on display"]}. You hear no sound of forging nearby."
      end
    end
  end # set_description()

  def create_owner(type)
    owner = Hash.new
    case type
    when "general"
      owner["race"] = rand_race()
      owner["name"] = rand_name(owner["race"])
      owner["gender"] = rand_gender()
      owner["stat"] = "Commoner"
    when "magic"
      owner["race"] = "Half-Elf"
      owner["name"] = rand_name(owner["race"])
      owner["gender"] = rand_gender()
      owner["stat"] = "Magic Shopkeeper (See Appendix)"
    when "tavern"
      owner["race"] = rand_race()
      owner["name"] = rand_name(owner["race"])
      owner["gender"] = rand_gender()
      owner["stat"] = "Commoner"
    when "temple"
      owner["race"] = "Human"
      owner["name"] = rand_name(owner["race"])
      owner["gender"] = rand_gender()
      owner["stat"] = "Temple Keeper (See Appendix)"
    when "weapons"
      owner["race"] = rand_race()
      owner["name"] = rand_name(owner["race"])
      owner["gender"] = rand_gender()
      owner["stat"] = "Commoner (with Strength 16 (+3), Dexterity 14 (+2) and expertise with leatherworker's and smith's tools)"
    end
    return owner
  end # create_owner()

  def rand_gender()
    return %w{Male Male Male Male Female Female Female Female Trans-Male Trans-Female Non-Binary Non-Binary}[rand(12)].to_s
  end # rand_gender

  def rand_race()
    return %w{Dragonborn Dwarf Dwarf Dwarf Dwarf Dwarf Elf Elf Elf Elf Gnome Gnome Gnome Half-Elf Half-Elf Half-Elf Half-Elf Half-Elf Half-Elf Halfling Halfling Halfling Halfling Halfling Halfling Halfling Half-Orc Half-Orc Half-Orc Human Human Human Human Human Human Human Human Human Human Human Human Human Human Human Human Human Human Human Human Tiefling}[rand(50)].to_s
  end # rand_race()

  def rand_name(race)
    name = ""
    case race
    when "Dragonborn"
      particles = {
        "prefix" => ["Althoc", "Caalxashtial", "Cardishtas", "Climbodujiash", "Climtas", "Climtear", "Clumrocus", "Craarrhacurdoth", "Cralmas", "Crastajec", "Crestushtul", "Daldranshtel", "Dethtos", "Dilken", "Dorthaandardid", "Drelrasteth", "Drirjustarrid", "Drirnosh", "Eldanked", "Elmandirgik", "Ephocmergesh", "Feastixamak", "Ferthacok", "Gamronec", "Gencasanid", "Gornunshtic", "Ilmontherad", "Imrad", "Kamtekiallear", "Klelkiaduamil", "Klialkur", "Klumpacmer", "Kluunxacmak", "Komted", "Konxinshtaarral", "Kothtekmith", "Kralkexuamar", "Kreampuataruad", "Krelthicmidik", "Kuurniajurgic", "Lanxixian", "Liammaaniardir", "Liamres", "Listondrijad", "Lomrijillul", "Lulmash", "Maastujod", "Mamphash", "Memphenshtar", "Mithton", "Muccacmargash", "Myaccondrergaak", "Myarrhal", "Myelmel", "Myemtashtith", "Myicishter", "Myildoxith", "Myuphudergeth", "Myuulxis", "Naldistiad", "Namphistuadin", "Nyaampocnal", "Nyerthuanshtundan", "Nyiampish", "Nyommastinas", "Nyornak", "Nyuustanthuth", "Ochen", "Oldotidush", "Ostil", "Prirakojas", "Prirthender", "Proldrijandaak", "Sherrhol", "Shiarjasek", "Shiccith", "Shirjistath", "Shixal", "Shochalimiash", "Shophororgac", "Shultaash", "Tecceturgin", "Thamphijer", "Thombaanthalled", "Thomphondrired", "Thuarnen", "Thuuldrindrac", "Ummosh", "Urnos", "Uthtetin", "Vachid", "Valdras", "Vaphak", "Veltoth", "Velxeasac", "Vimbistanes", "Visteshtoc", "Yernuakiash", "Yiarrhur", "Yimmuc"],
        "suffix" => ["Alilin", "Aliwunax", "Balbarum", "Baqull", "Biyassa", "Brenziros", "Caerfras", "Caergrax", "Caeryax", "Caluwarum", "Crisyries", "Davyre", "Doseth", "Drabarum", "Draprax", "Drysrinn", "Drysvys", "Dryszys", "Eraqiroth", "Erlirina", "Faerdhall", "Fengil", "Fenrith", "Grelasar", "Grenaar", "Gribis", "Gurwophyl", "Hagwen", "Hexiros", "Hinriel", "Hinwophyl", "Iordorim", "Iorythas", "Irlynys", "Irlyyries", "Jarxan", "Jesliann", "Jokira", "Kelcoria", "Kelvyre", "Kelxora", "Kilturim", "Lilovys", "Lorasaadi", "Lumidorim", "Lumiqiroth", "Medxiros", "Morkax", "Morxiros", "Morzire", "Nadrith", "Naliann", "Narkax", "Nawunax", "Naxan", "Nesthyra", "Nesvayla", "Nyskaryn", "Nyslarys", "Nysvyre", "Ophirith", "Ovayla", "Patrin", "Pervayla", "Qigil", "Quilmeila", "Rascrath", "Rasghull", "Raszire", "Ravobarum", "Ravodhall", "Shafras", "Sobith", "Sokira", "Sulxiros", "Uromash", "Urovarax", "Valpora", "Valqorel", "Vorziros", "Vyrakaryn", "Vyralarys", "Vyraliann", "Welsirinn", "Worlasar", "Wormash", "Wulyax", "Wuturim", "Xarlasar", "Xisbirith", "Xisthibra", "Xybis", "Xyrann", "Yagil", "Yorkul", "Zendrith", "Zenrina", "Zorlin", "Zorxiros", "Zrawarum"]
      }
      name = "#{particles["prefix"][rand(particles["prefix"].length)]} #{particles["suffix"][rand(particles["suffix"].length)]}"
    when "Dwarf"
      particles = {
        "prefix" => ["Amnir", "Annas", "Annora", "Arras", "Baerrig", "Banmun", "Banthran", "Bardrom", "Belledyl", "Belleros", "Benadin", "Bralnura", "Bramdus", "Bramrak", "Bretmyl", "Brillelyl", "Brillemyla", "Brilwynn", "Bronlen", "Bronlynn", "Brulla", "Bryllemyla", "Brynwaen", "Brytmura", "Dalkyl", "Dardur", "Darmyl", "Dearnar", "Dearres", "Doldrum", "Eddielle", "Emnik", "Gemdielle", "Gemdora", "Germera", "Graldain", "Gramdrom", "Gramnik", "Grangarn", "Gremdal", "Gremkam", "Grenrak", "Gulram", "Gwanlyl", "Gwenrin", "Hardek", "Harmiir", "Harnum", "Hjolthran", "Hormun", "Hurdahr", "Jennnas", "Jinmyl", "Jynwynn", "Karrom", "Kathgwyn", "Kathleil", "Ketdielle", "Khargrom", "Khartharm", "Krommin", "Krumkam", "Lassros", "Maerdryn", "Maermera", "Maerrin", "Marthiel", "Murryl", "Mysnis", "Nastyn", "Nisrielle", "Ranmyr", "Redbelle", "Regnum", "Rynva", "Solglian", "Tasla", "Tasnora", "Tharkum", "Tharmond", "Theldur", "Therkahm", "Thernum", "Thoadin", "Thokyl", "Thonam", "Thurmir", "Thurrig", "Thydrom", "Tishnar", "Tizdyl", "Torras", "Tyshlinn", "Tyshnora", "Tyshwaen", "Tyshwin", "Vonkam", "Vonkohm", "Vonmyr", "Vonrus"],
        "suffix" => []
      }
      name = "#{particles["prefix"][rand(particles["prefix"].length)]} #{particles["suffix"][rand(particles["suffix"].length)]}"
    when "Elf"
      particles = {
        "prefix" => ["Balcan", "Beixalim", "Bilana", "Biyra", "Caileth", "Carfir", "Carhorn", "Carven", "Carwraek", "Chaezorwyn", "Daevaris", "Dakrana", "Dalee", "Dazorwyn", "Elaris", "Enrora", "Erjeon", "Erneiros", "Faerora", "Fardan", "Fenfir", "Fennan", "Fensandoral", "Glynnelis", "Helerona", "Herren", "Holarel", "Ianmenor", "Iantumal", "Inaxina", "Inaynore", "Kelnorin", "Keythana", "Keyxina", "Krisharice", "Liagwyn", "Liasys", "Lujeon", "Miraric", "Naecan", "Naedithas", "Naemenor", "Norran", "Norzumin", "Olarie", "Oloris", "Oloydark", "Omabalar", "Omasalor", "Orilynn", "Orizana", "Perhice", "Pertumal", "Petpetor", "Phidove", "Phikrana", "Qinwarin", "Qirieth", "Quirona", "Ralozeiros", "Ravazorwyn", "Shabanise", "Shacyne", "Shafina", "Sylgella", "Sylmaris", "Sylpeiros", "Sylrel", "Torvyre", "Trazumin", "Tristhyra", "Ulara", "Umeris", "Urisalor", "Urisys", "Urixisys", "Valfiel", "Valgella", "Valralei", "Venvaris", "Virzeiros", "Waeslamin", "Waeswarin", "Wranfaren", "Wynwynn", "Xilfiel", "Xilstina", "Xyrrieth", "Xyryra", "Yellamin", "Yelris", "Yesphine", "Yinvalur", "Yllacyne", "Ylladove", "Zummaris", "Zumtoris", "Zylkrana"],
        "suffix" => []
      }
      name = "#{particles["prefix"][rand(particles["prefix"].length)]} #{particles["suffix"][rand(particles["suffix"].length)]}"
    when "Gnome"
      particles = {
        "prefix" => ["Algrim", "Aluhani", "Arigyra", "Arimin", "Arisany", "Banssa", "Breegyra", "Breemila", "Brinan", "Calpos", "Cardira", "Carkasys", "Carqaryn", "Corhim", "Daphinoa", "Davhim", "Eilibys", "Eilitra", "Erpos", "Felston", "Fenhana", "Galen", "Galmyra", "Grenbys", "Helfyx", "Helkini", "Iparyn", "Isoxis", "Isozyre", "Jekas", "Jeldysa", "Jelgyra", "Jelxi", "Jenan", "Jorkur", "Joroe", "Jorziver", "Kasser", "Kastor", "Kelxim", "Kloxi", "Lanbis", "Lowin", "Mernan", "Mindysa", "Nestor", "Nicorin", "Ormin", "Panadri", "Panawin", "Popip", "Poston", "Quaros", "Quaston", "Quobis", "Refi", "Renove", "Ronfiz", "Rosimyra", "Sahana", "Salbar", "Sinziver", "Tanvyn", "Taza", "Tifaci", "Tifamyra", "Tomorn", "Toxif", "Toxim", "Trapos", "Triniana", "Valdri", "Venlys", "Venxis", "Vobys", "Vorvyn", "Voza", "Weldira", "Welmyra", "Wilnan", "Wrecryn", "Wrerug", "Wrola", "Wrosys", "Xaxis", "Xobis", "Xojin", "Xyromila", "Xyroqaryn", "Yetor", "Ylobys", "Ylotra", "Yloyaris", "Yonove", "Yosgim", "Yosji", "Zanbar", "Zanimiphi", "Zilmop", "Zinnoa"],
        "suffix" => []
      }
      name = "#{particles["prefix"][rand(particles["prefix"].length)]} #{particles["suffix"][rand(particles["suffix"].length)]}"
    when "Half-Elf"
      particles = {
        "prefix" => ["Alygalyn", "Alymae", "Arotorin", "Belovar", "Belparin", "Brentrana", "Bynnys", "Byntheris", "Dardiane", "Davqarim", "Delfaen", "Delviel", "Dortorin", "Eirben", "Elavor", "Eldiane", "Elgalyn", "Faekilia", "Faeyaries", "Falphanis", "Fhagwynn", "Fhaqwyn", "Frilneak", "Gaerril", "Gifhophe", "Giftheris", "Graavor", "Halstaer", "Halyzenya", "Horfaerd", "Hovyre", "Ianynor", "Ilegalyn", "Ilelahne", "Ilemae", "Ilevyre", "Iloben", "Ilovalor", "Jamkas", "Jilkilia", "Kevdithas", "Kriben", "Krinan", "Kritorin", "Krivalor", "Kriwarith", "Kriword", "Lesyaries", "Lorarora", "Lorkas", "Maona", "Marfine", "Meifyr", "Nilxian", "Nororin", "Norword", "Oldove", "Olgwynn", "Olmythe", "Ophithana", "Oricoril", "Orivoril", "Osdithas", "Pangretor", "Prizenya", "Quelynn", "Quemalis", "Quowarith", "Relkaen", "Relpisys", "Ridithas", "Saelhophe", "Saelrora", "Sarovar", "Sylgotin", "Syltheris", "Sylvalor", "Sylxipha", "Uanavor", "Uancraes", "Ulynor", "Uriqarin", "Venseris", "Viclumin", "Walneiros", "Walvalor", "Wilkas", "Wolqwyn", "Xanenas", "Xanphanis", "Xanzaphir", "Xavqarim", "Xilgwynn", "Xilkilia", "Xyrtrana", "Xyrxipha", "Yenorin", "Yesbwynn", "Yescerys", "Zelxaris"],
        "suffix" => []
      }
      name = "#{particles["prefix"][rand(particles["prefix"].length)]} #{particles["suffix"][rand(particles["suffix"].length)]}"
    when "Halfling"
      particles = {
        "prefix" => ["Artran", "Arwan", "Arzu", "Barvon", "Belhace", "Belrana", "Beltran", "Corvon", "Darrana", "Darri", "Diaalyn", "Diayola", "Eibyn", "Eldal", "Eldon", "Elkas", "Eradove", "Erajen", "Ervias", "Faylienne", "Finret", "Flynster", "Flynumo", "Frodove", "Gelphina", "Gelvira", "Gobin", "Gomo", "Gover", "Halyas", "Hari", "Horzor", "Idani", "Idopos", "Idowrick", "Iranad", "Iraorin", "Isazira", "Jandak", "Jandal", "Janwrick", "Jayni", "Jilfira", "Jilmita", "Jovias", "Kelprys", "Kithne", "Lemia", "Linumo", "Marri", "Orabrix", "Oralie", "Oraree", "Osver", "Paeula", "Perace", "Permo", "Perser", "Pimric", "Qualyn", "Qugrace", "Quora", "Quris", "Ribyn", "Saula", "Shaesica", "Shaetina", "Shardon", "Tarpher", "Tarver", "Tezin", "Thermita", "Therprys", "Ullan", "Unazana", "Valret", "Vergrace", "Vindon", "Welvyre", "Wenlan", "Wenser", "Wilsire", "Wiula", "Xanamin", "Xanos", "Xicey", "Xiora", "Xiri", "Xohace", "Yarfer", "Yarser", "Yesnys", "Yoeni", "Yoree", "Zalemin", "Zalhace", "Zefla", "Zenmia"],
        "suffix" => []
      }
      name = "#{particles["prefix"][rand(particles["prefix"].length)]} #{particles["suffix"][rand(particles["suffix"].length)]}"
    when "Half-Orc"
      particles = {
        "prefix" => ["Aragum", "Atretur", "Bradash", "Bruda", "Dridak", "Durorak", "Falori", "Felagar", "Foligar", "Fulagri", "Fulozur", "Galodurk", "Girook", "Goradur", "Goram", "Gorinar", "Gorinur", "Gramug", "Gryezar", "Hadar", "Hogoruk", "Hogurk", "Hunugash", "Huragak", "Hururimm", "Kamim", "Karadur", "Karitur", "Katud", "Keliburk", "Kerene", "Ketini", "Kilatir", "Kizar", "Komask", "Komumak", "Kurane", "Lagigu", "Lagimur", "Lagizira", "Lumedall", "Mahlagur", "Maran", "Miti", "Mokarall", "Mugadurk", "Namir", "Nonchu", "Noner", "Ogguimak", "Ogguudurk", "Oguinars", "Olerook", "Olimi", "Olozara", "Ootigu", "Ootorook", "Rahasha", "Rahug", "Rasusha", "Rawigu", "Rohitur", "Rohkisha", "Rohkitur", "Roni", "Sebur", "Semedar", "Semogu", "Seniwar", "Shayomar", "Shuwar", "Sinizira", "Soraruk", "Sumizira", "Sunatur", "Sutir", "Tamagar", "Tharunars", "Therutir", "Thrusk", "Thurugash", "Trakadark", "Trukuzar", "Tuid", "Ubazira", "Ugamarsh", "Ugodash", "Ukunur", "Ulladak", "Ullarth", "Ullibark", "Ullorim", "Umosha", "Urtrark", "Zaragul", "Zavonur", "Zevebak", "Zevurash", "Zonimur", "Zoninur"],
        "suffix" => []
      }
      name = "#{particles["prefix"][rand(particles["prefix"].length)]} #{particles["suffix"][rand(particles["suffix"].length)]}"
    when "Human"
      particles = {
        "prefix" => ["Abum", "Adrath", "Adud", "Alm", "Alrevro", "Bafro", "Bamafni", "Behumuf", "Beud-Venaok", "Bharer", "Bicrel", "Bihnur", "Bilmit", "Bithefnay", "Blogroth", "Bolo", "Bram", "Breldorth", "Bridjirzout", "Brikrug", "Brom", "Bui", "Cehohis", "Cerlo", "Che", "Chenchos", "Chion", "Chisuro", "Chulu", "Creveadrin", "Dettq", "Devrulne", "Dia", "Din", "Doulvorzid", "Dralmask", "Drorlisdesk", "Ducral", "Dulven", "Ea", "Eded", "Eelsoznieh", "Eidal", "Eled", "Elzedre", "Emih", "Emmiru", "Ere", "Ertf", "Famu", "Fargis", "Faze", "Fecarnin", "Fescola", "Fi", "Finrasvas", "Finrout", "Fiphu", "Fosd", "Fram", "Fushifeh", "Galdout", "Gijis", "Glasan", "Gler", "Gootvendit", "Graldil", "Grar", "Gree", "Grigen", "Grum", "Grundud", "Grur", "Haiza", "Haminuh", "Hamminri", "Heh", "Hestre", "Hie", "Hif", "Hindom", "Hiow", "Hirgel", "Hirren", "Hon", "Horfie", "Hoshuthi", "Hungod", "Iah", "Iam", "Iflami", "Iga", "Ihruhleih", "Illar", "Imvarlu", "Iow", "Ireleih", "Ishilray", "Jamum", "Jeidf", "Jikaf", "Jimoomvot", "Jindra", "Ji-Riohpud", "Jorlirro", "Jui", "Kehvaor", "Kerme", "Kikim-Vih", "Kodral", "Kogi", "Kohved", "Kolzorull", "Kuluphah", "La", "Ladvom", "Laidq", "Lalgethe", "Lalri", "Lao", "Leivj", "Lelna", "Lerth", "Letv", "Liao", "Liap", "Lien", "Lik-Deur", "Lisumi", "Loniodu", "Luhezhi", "Lui", "Lurruh", "Ma", "Maitul", "Mamid", "Manchenear", "Mar", "Melud", "Mevele", "Mi", "Mienildro", "Mihroh", "Milim", "Mindok", "Mivu", "Molj", "Mom", "Mosva", "Mue", "Muvresh", "Najihpeth", "Nakvig", "Narrafal", "Nefuphoh", "Nefutel", "Nes", "Nesnadil", "Nhebad", "Nia", "Nithoh", "Nof", "Novin", "Nuduh", "Nue", "Nuhmam", "Nuhmur", "Nurded", "Nurrachi", "Nuvihmul", "Nuzra", "Ogam", "Ogrurth", "Olcuth", "On", "Or", "Ottd", "Paimie", "Qintv", "Qion", "Radrith", "Rarstid", "Razean", "Regrar", "Remvis", "Rilmo", "Rini", "Riu", "Rokiros", "Rolazu", "Rolna", "Rono", "Ronred", "Rotel", "Rotomal", "Rushur", "Salmi", "Se", "Sebrof", "Seldrai", "Senteanrol", "Sethres", "Shalrolzal", "Shan", "Shanah", "Shin", "Shudre", "Shuip", "Silrishi", "Son-Dus", "Starvarn", "Sussilol", "Ta", "Talsil", "Tan", "Tarvostis", "Terstun", "Tha", "Tharo", "Thiodajuh", "Tia", "Toa", "Topha", "Traldarth", "Trercur", "Uantd", "Vanef", "Vava", "Vegrursi", "Venb", "Vevd", "Virsis", "Vurfitez", "Warho", "Wetha", "Xai", "Xiao", "Yai", "Yaruvoh", "Yemmavren", "Yifre", "Yutoh", "Zei", "Zepeh", "Zijesdar", "Zorzozod", "Zova", "Zozhe", "Zudim", "Zue", "Zun", "Zurvirfes", "Zusnih"],
        "suffix" => ["Ain", "Antedzu", "Anzodzedza", "Aon", "Astime", "Bahran", "Barkan", "Barleybow", "Bekrefk", "Bendrupvahr", "Bhaha", "Bheshim", "Bhinna", "Bidrobre", "Bostasor", "Burihe", "Cao", "Cargigil", "Cekhe", "Chain", "Chan", "Chao", "Charsk", "Cheluv", "Chirure", "Chivrarsk", "Chodz", "Chonersk", "Chua", "Cindermark", "Clantrack", "Clawcleaver", "Clearkeep", "Coldrider", "Costi", "Cragrider", "Crestmaul", "Crestvigor", "Cua", "Dantuvzavya", "Darsk", "Dasulba", "Derduz", "Dhussed", "Dihrem", "Dononzi", "Dugyeve", "Dunnan", "Dussar", "Dustela", "Dustfollower", "Dustgrain", "Evzavre", "Fachald", "Featherdew", "Fechefk", "Filerni", "Fipvim", "Flintbreeze", "Foregrove", "Forespear", "Fourore", "Freeforest", "Frostbloom", "Fullsteam", "Gagonorge", "Geldagongo", "Giscumon", "Gitrida", "Gletsk", "Glisk", "Goldrun", "Gorespire", "Greenridge", "Grevryekyagi", "Grezadz", "Gulbengo", "Hahlu", "Hahru", "Hallowbreeze", "Hazeblood", "Hazeglade", "Hecruhkahk", "Hematrovu", "Henzenkhaft", "Hillflayer", "Hinnud", "Hirgoru", "Holyhorn", "Horgolbo", "Horsebrook", "Huldudo", "Hundreft", "Istemo", "Jahlem", "Janel", "Jiam", "Jie", "Jin", "Jizascil", "Jobrohal", "Joscorgar", "Ju", "Juenkhezrefk", "Juevrihk", "Jugosqo", "Kadz", "Kain", "Khahram", "Khaken", "Khelan", "Khuma", "Khune", "Korsk", "Koviz", "Laughingmaul", "Lay", "Leafvale", "Lelihk", "Lihpuezikt", "Liltruhrekt", "Lowwater", "Makha", "Makrask", "Masterbreeze", "Mathyemu", "May", "Meadowspear", "Megiva", "Mia", "Milrufk", "Mirnorkadzi", "Miz", "Monnem", "Morningvalor", "Movrodz", "Murnunda", "Muromu", "Muuzdikrahd", "Nav", "Nehraltuld", "Nev", "Niao", "Noblebrace", "Nobleflare", "Nosegrip", "Nusk", "Nuunkrohk", "Nuvrisk", "Oceanjumper", "Olinzol", "Ononguga", "Ozoza", "Pai", "Pan", "Pastucor", "Piaom", "Pinebrooke", "Pinetrap", "Plainshield", "Plaintide", "Qaong", "Racruenzik", "Ragestream", "Rahlu", "Ravinthuld", "Renilde", "Rhelod", "Rinnu", "Roseglory", "Rudidz", "Rundum", "Rungothoge", "Ruulolehk", "Sahpeld", "Sain", "Seawhisk", "Senudz", "Sethrekt", "Shannor", "Sharpmaul", "Shikesk", "Shileid", "Shirkun", "Shiste", "Sia", "Sihuzu", "Silentglory", "Silentstriker", "Sinuver", "Sirnitsk", "Sisqahon", "Skybough", "Solboscis", "Sov", "Spiderflame", "Springrunner", "Steelbough", "Sternriver", "Stidz", "Stonebloom", "Stonespirit", "Stonewhirl", "Stontagigi", "Stunilbo", "Susiza", "Suy", "Tevurku", "Thunderbreath", "Tie", "Tiey", "Trorgogyengi", "Uang", "Urulbus", "Utvunogu", "Vacruzdaft", "Van", "Vandahkit", "Vanduhpihd", "Varorsk", "Vask", "Vastecul", "Vatrolmive", "Venthik", "Venzem", "Venziles", "Vrakinu", "Vregurga", "Vrugemarge", "Vutrirero", "Wiao", "Winterstream", "Woodenhell", "Wyvernflame", "Wyverngem", "Wyvernvigor", "Xaom", "Xian", "Youngwinds", "Youngwolf", "Zahpakruuld", "Zaleid", "Zalon", "Zalzamzi", "Zaom", "Zazihus", "Zemengo", "Zilbone", "Zista", "Zoshe", "Zuethreld", "Zuhruluuhk", "Zumzyatvonzo", "Zusse"]
      }
      name = "#{particles["prefix"][rand(particles["prefix"].length)]} #{particles["suffix"][rand(particles["suffix"].length)]}"
    when "Tiefling"
      particles = {
        "prefix" => ["Adventure", "Aetrus", "Afpione", "Akilius", "Aklius", "Amakas", "Anguish", "Anicria", "Anilyvia", "Aniyola", "Aranxes", "Araqine", "Aravari", "Ariadani", "Ariaxori", "Ariqine", "Arkilius", "Arkris", "Awe", "Barcis", "Barvius", "Barxire", "Bright", "Brixibis", "Caremon", "Casrut", "Casxikas", "Cheer", "Cherish", "Comfort", "Content", "Courage", "Crenise", "Dabis", "Dameia", "Damrai", "Danarei", "Danise", "Daspira", "Devotion", "Dilith", "Dimaia", "Dorseis", "Dorza", "Ealaia", "Eanirith", "Ekmenos", "Essential", "Esteem", "Eternal", "Expressive", "Extreme", "Fear", "Free", "Freedom", "Fresh", "Garnon", "Garrakas", "Garrakir", "Gentle", "Gladness", "Gloom", "Gririssa", "Guexire", "Guxik", "Guxius", "Happy", "Harmony", "Hishala", "Hislia", "Hisspira", "Horcius", "Hunt", "Iados", "Ideal", "Inigrea", "Iniki", "Kaiakos", "Kaiil", "Karrut", "Karus", "Kilil", "Kosadius", "Kosrius", "Kyrias", "Kyron", "Laughter", "Levnise", "Levrali", "Life", "Lilyola", "Lokeakas", "Lokelius", "Love", "Maleichar", "Marnise", "Marseis", "Mastery", "Mavakos", "Meira", "Mexius", "Mexus", "Misery", "Misgoria", "Misseis", "Morilius", "Natari", "Nefirith", "Nelith", "Nephmus", "Nephreus", "Nephzer", "Nepione", "Netari", "Nethlyvia", "Nithcyra", "Nithdoris", "Nithtish", "Nithuphis", "Nithza", "Nowhere", "Oriyis", "Ozshoon", "Perfect", "Phelith", "Piety", "Poetry", "Possession", "Promise", "Psalm", "Pure", "Quest", "Quqine", "Qutari", "Ralmarir", "Ralrakir", "Recovery", "Relentless", "Respect", "Revenom", "Reverence", "Rexius", "Rolzire", "Rotish", "Rowure", "Saborys", "Sacyra", "Salia", "Seiricria", "Sirlech", "Sirxikas", "Skail", "Skamus", "Skilled", "Song", "Sorrow", "Terror", "Theakos", "Thynereus", "Thynexikas", "Thynexius", "Thyris", "Unlocked", "Urcis", "Urimeros", "Urvenom", "Valcius", "Valcria", "Valilius", "Velyola", "Void", "Weary", "Winning", "Woe", "Xarvir", "Xarzer", "Yaborys", "Yarali", "Yumaia", "Yuvari", "Yuwure", "Zailies", "Zairissa", "Zarrut", "Zaspira", "Zefaris", "Zegrea", "Zepione", "Zerlyre", "Zershoon", "Zherakos", "Zoradius"],
        "suffix" => []
      }
      name = "#{particles["prefix"][rand(particles["prefix"].length)]} #{particles["suffix"][rand(particles["suffix"].length)]}"
    else
      particles = {
        "prefix" => ["Ashlion", "Atomhound", "Atomjackal", "Bighusky", "Blacktail", "Brightleopard", "Bronzebunny", "Bronzeunicorn", "Cindercoat", "Commonmane", "Crestbunny", "Crestfox", "Crystalsnout", "Crystalunicorn", "Darkliger", "Darkpelt", "Dawncat", "Dawncoyote", "Dawntiger", "Dewfennec", "Dreamfox", "Dusthorse", "Dustsnout", "Earthcrown", "Earthmane", "Emberbunny", "Eveningclaw", "Eveningpelt", "Feathercat", "Feralcrown", "Feraldog", "Forestcoat", "Freestud", "Frenzyhusky", "Furyhorse", "Gloomcrown", "Goldhound", "Grandfang", "Grimhound", "Icekitten", "Ironbunny", "Ironleopard", "Lightninghoof", "Lightningvixen", "Lunapanther", "Magiccat", "Meadowkitten", "Moonfur", "Moonlion", "Moontiger", "Morninglion", "Mountainstud", "Nightheart", "Noblehound", "Nobletiger", "Oldvixen", "Palefox", "Paleunicorn", "Priderabbit", "Rainbowliger", "Rapidcat", "Razorvixen", "Regalkitty", "Riverfox", "Roughbunny", "Runehound", "Shadeface", "Shortbunny", "Shortdog", "Shortkitten", "Shortpony", "Shortvixen", "Silentface", "Skytiger", "Snowcrest", "Softpony", "Solarliger", "Sparkfang", "Sparkhunter", "Springsnout", "Stoneunicorn", "Strongpony", "Tallbunny", "Talldog", "Thundertiger", "Trueface", "Truekitten", "Velvetcrown", "Velvethunter", "Whitepelt", "Wildunicorn", "Winterbat", "Winterwolf", "Wiseleopard", "Wisepaw", "Woodfox", "Woodstud", "Youngliger", "Youngtail"],
        "suffix" => ["Activetongue", "Adeptnose", "Adorablehide", "Agilefangs", "Ampletail", "Ancientclaws", "Ancienteyes", "Ancientfang", "Ancientskin", "Angryclaws", "Angrywing", "Awkwardfang", "Badwings", "Baggymask", "Baggyscream", "Bigtooth", "Bitternose", "Bouncymug", "Bouncypaws", "Bouncyshadow", "Bravepaw", "Briskeye", "Bubblytooth", "Cleverhoof", "Clevertail", "Coarsehowl", "Coldpaw", "Courageplumes", "Courageshadow", "Craftyeyes", "Craftymeow", "Crazypelt", "Crazyyelp", "Cruelmeow", "Curlyhoof", "Cutescream", "Cutewing", "Dappermask", "Dimpaw", "Faintmask", "Fairtooth", "Falsetail", "Flashypaw", "Fluffycrest", "Fluffyshadow", "Freshhowl", "Freshtooth", "Friendlyclaws", "Friendlyface", "Funnynose", "Fuzzywings", "Gentlehowl", "Gentleplumes", "Gracefur", "Greedybones", "Hardeyes", "Humblefur", "Jollyface", "Killermask", "Killernails", "Killerwings", "Largecoat", "Lazymane", "Lazypelt", "Leanpaws", "Lightsmirk", "Littlenails", "Loudwings", "Madpelt", "Meanfang", "Mellowsmirk", "Mildbone", "Mildcoat", "Mildmug", "Naughtyfang", "Oddeye", "Oddtongue", "Prettycoat", "Proudcrest", "Rabidfeather", "Rapidface", "Richtooth", "Roguecrest", "Sadblade", "Scaredcrest", "Scaryface", "Scaryfangs", "Secretmug", "Sillygrowl", "Sillyscream", "Sillyyelp", "Silverface", "Slickheart", "Slyhoof", "Slypaw", "Stronggrowl", "Tenderclaw", "Vainfeathers", "Weirdbane", "Wickedeye"]
      }
      name = "#{particles["prefix"][rand(particles["prefix"].length)]} #{particles["suffix"][rand(particles["suffix"].length)]}"
    end
    return name.strip
  end # rand_name()

  def create_rumor()
    pieces = {
      "when"      => ["a year ago from tonight", "one night last month", "twice last month", "twice last week", "one day last week", "one night last week", "three nights ago", "the day before yesterday", "the night before last", "yesterday morning", "yesterday afternoon", "just before sunset", "after sunset", "after nightfall", "before midnight", "past midnight", "in the wee hours", "just before dawn", "at daybreak", "earlier today"],
      "who"       => ["the queen", "a farmer", "a merchant", "a wizard", "a soldier", "a cleric", "a druid", "an orphan", "a sailor", "a thief", "a miner", "a lord", "a knight", "the mayor", "an innkeeper", "a dwarf", "an elf", "a singer", "a pirate", "a witch"],
      "with-what" => ["a prostitute", "a drunk", "an artefact", "a talking sword", "a Drow", "an escaped convict", "a vial of poison", "a book of spells", "a talking animal", "a sack of coins", "the prince/princess", "a fortune teller", "an alchemist", "an assassin", "a barmaid", "a beggar", "a saddled horse", "a hunting hound", "a mule and cart", "a fake mustache"],
      "where"     => ["the docks", "the palace", "the crafts guild", "the mages guild", "the brothel", "the merchant quarter", "the tavern", "the prison", "the museum", "the asylum", "the library", "the barracks", "the gatehouse", "the bridge", "the temple", "the market square", "the warehouse district", "the garden district", "the lighthouse", "the riverfront"],
      "was-what"  => ["a dead commoner", "a dead monster", "an explosion", "a bloody weapon", "a planar gate", "a demon", "a vampire", "an angry mob", "a dead noble", "an arcane sigil", "a frightened crowd", "an angel", "a devil", "a series of claw marks", "a series of scorch marks", "an empty vial", "a burned book", "a werewolf", "a ghost", "a horde of zombies"],
      "whom"      => ["a shopkeeper", "a basketweaver", "a grocer", "a peddler", "a beggar", "an urchin", "a barkeep", "a serving girl", "a squire", "a musician", "a madame", "a watchman", "a ship's captain", "a peasant woman", "a fisherman's wife", "a monk", "a sellsword", "a gambler", "some guy in a pub", "a little bird"],
      "veracity"  => ["might be true", "must be true", "has to be true", "can't be true", "could be true", "is definitely true", "may be true", "is likely true", "is possibly true", "is certainly true", "is absolutely true", "is probably true", "is likely partially true", "is definitely not true", "can't be entirely false", "isn't likely false", "isn't likely entirely false", "might not be true", "isn't likely the whole story", "is probably just idle gossip"]
    }
    rumor = "I heard that, #{pieces["when"][rand(pieces["when"].length)]}, #{pieces["who"][rand(pieces["who"].length)]} was seen with #{pieces["with-what"][rand(pieces["with-what"].length)]} down near #{pieces["where"][rand(pieces["where"].length)]} and nearby there was #{pieces["was-what"][rand(pieces["was-what"].length)]}. I heard it from #{pieces["whom"][rand(pieces["whom"].length)]}, so it #{pieces["veracity"][rand(pieces["veracity"].length)]}."
  end # create_rumor()

  def set_rate(transaction)
    rate = rand(1..5)/10.0
    if transaction == "sell"
      return (0.8 + rate).to_f
    else
      return (0.4 + rate).to_f
    end
  end # set_rate()

  def set_fix_stock(type, rate)
    stock = ''
    case type
    when "general"
      stock = [["Abacus", "Adventuring Gear", 200, ""], ["Acid (vial)", "Adventuring Gear", 2500, ""], ["Alchemist's fire (flask)", "Adventuring Gear", 5000, ""], ["Backpack", "Adventuring Gear", 200, ""], ["Ball Bearings (bag)", "Adventuring Gear", 100, ""], ["Barrel", "Adventuring Gear", 200, ""], ["Basic Poison (vial)", "Adventuring Gear", 10000, ""], ["Basket", "Adventuring Gear", 40, ""], ["Bedroll", "Adventuring Gear", 100, ""], ["Bell", "Adventuring Gear", 100, ""], ["Blanket", "Adventuring Gear", 50, ""], ["Block and Tackle", "Adventuring Gear", 100, ""], ["Bucket", "Adventuring Gear", 5, ""], ["Bullseye Lantern", "Adventuring Gear", 1000, ""], ["Caltrops (bag of 20)", "Adventuring Gear", 100, ""], ["Candle", "Adventuring Gear", 1, ""], ["Chain (10 feet)", "Adventuring Gear", 500, ""], ["Chalk (1 piece)", "Adventuring Gear", 1, ""], ["Chest", "Adventuring Gear", 500, ""], ["Crossbow Bolt case", "Adventuring Gear", 100, ""], ["Crowbar", "Adventuring Gear", 200, ""], ["Fishing tackle", "Adventuring Gear", 100, ""], ["Grappling hook", "Adventuring Gear", 200, ""], ["Hammer", "Adventuring Gear", 100, ""], ["Hempen Rope (50 ft)", "Adventuring Gear", 100, ""], ["Hooded Lantern", "Adventuring Gear", 500, ""], ["Hourglass", "Adventuring Gear", 2500, ""], ["Hunting trap", "Adventuring Gear", 500, ""], ["Iron Pot", "Adventuring Gear", 200, ""], ["Iron Spikes (10)", "Adventuring Gear", 100, ""], ["Ladder (10-foot)", "Adventuring Gear", 10, ""], ["Lamp", "Adventuring Gear", 50, ""], ["Lock", "Adventuring Gear", 1000, ""], ["Magnifying glass", "Adventuring Gear", 10000, ""], ["Manacles", "Adventuring Gear", 200, ""], ["Map or Scroll case", "Adventuring Gear", 100, ""], ["Merchant's Scale", "Adventuring Gear", 500, ""], ["Mess kit", "Adventuring Gear", 20, ""], ["Miner's Pick", "Adventuring Gear", 200, ""], ["Oil (flask)", "Adventuring Gear", 10, ""], ["Perfume (vial)", "Adventuring Gear", 500, ""], ["Piton", "Adventuring Gear", 5, ""], ["Pole (10-foot)", "Adventuring Gear", 5, ""], ["Portable Ram", "Adventuring Gear", 400, ""], ["Pouch", "Adventuring Gear", 50, ""], ["Quiver", "Adventuring Gear", 100, ""], ["Sack", "Adventuring Gear", 1, ""], ["Shovel", "Adventuring Gear", 200, ""], ["Signal whistle", "Adventuring Gear", 5, ""], ["Signet ring", "Adventuring Gear", 200, ""], ["Silken Rope (50 ft)", "Adventuring Gear", 1000, ""], ["Sledge Hammer", "Adventuring Gear", 200, ""], ["Soap", "Adventuring Gear", 2, ""], ["Spyglass", "Adventuring Gear", 100000, ""], ["Steel Mirror", "Adventuring Gear", 500, ""], ["Tinderbox", "Adventuring Gear", 50, ""], ["Torch", "Adventuring Gear", 1, ""], ["Two-Person Tent", "Adventuring Gear", 200, ""], ["Waterskin", "Adventuring Gear", 20, ""], ["Whetstone", "Adventuring Gear", 1, ""], ["Common Clothes", "Clothing", 50, ""], ["Costume Clothes", "Clothing", 500, ""], ["Fine Clothes", "Clothing", 1500, ""], ["Traveler's Clothes", "Clothing", 200, ""]]
    when "magic"
      stock = [["Book", "Adventuring Gear", 2500, "Books on Arcana and History"], ["Glass Bottle", "Adventuring Gear", 200, ""], ["Ink (1 ounce bottle)", "Adventuring Gear", 1000, ""], ["Ink pen", "Adventuring Gear", 2, ""], ["Map or Scroll case", "Adventuring Gear", 100, ""], ["Paper (one sheet)", "Adventuring Gear", 20, ""], ["Parchment (one sheet)", "Adventuring Gear", 10, ""], ["Sealing wax", "Adventuring Gear", 50, ""], ["Spellbook", "Adventuring Gear", 5000, "No spells written"], ["Vial", "Adventuring Gear", 100, ""], ["Component pouch", "Arcane Focus", 2500, ""], ["Crystal", "Arcane Focus", 1000, ""], ["Orb", "Arcane Focus", 2000, ""], ["Rod", "Arcane Focus", 1000, ""], ["Staff", "Arcane Focus", 1000, ""], ["Wand", "Arcane Focus", 500, ""], ["Robes", "Clothing", 100, ""], ["Dispel Magic", "Spell", 10000, ""], ["Identify", "Spell", 11000, ""], ["Sending", "Spell", 5000, ""]]
    when "tavern"
      stock = [["Flask or tankard", "Adventuring Gear", 2, ""], ["Jug or pitcher", "Adventuring Gear", 2, ""], ["Rations (1/day)", "Adventuring Gear", 50, ""], ["Ale (gallon)", "Drink", 20, ""], ["Ale (mug)", "Drink", 4, ""], ["Common Wine (pitcher)", "Drink", 20, ""], ["Fine Wine (bottle)", "Drink", 1000, ""], ["Banquet (per person)", "Food", 1000, ""], ["Chunk of Meat", "Food", 30, ""], ["Hunk of Cheese", "Food", 10, ""], ["Good bedroom (per day)", "Lodging", 200, "Includes meals for the day"], ["Regular bedroom (per day)", "Lodging", 50, "Includes meals for the day"]]
    when "temple"
      stock = [["Antitoxin (vial)", "Adventuring Gear", 5000, ""], ["Book", "Adventuring Gear", 2500, "Books on Religion only"], ["Candle", "Adventuring Gear", 1, ""], ["Glass Bottle", "Adventuring Gear", 200, ""], ["Healer's kit", "Adventuring Gear", 500, ""], ["Holy water (flask)", "Adventuring Gear", 2500, ""], ["Sealing wax", "Adventuring Gear", 50, ""], ["Vial", "Adventuring Gear", 100, ""], ["Robes", "Clothing", 100, ""], ["Sprig of mistletoe", "Druidic Focus", 100, ""], ["Totem", "Druidic Focus", 100, ""], ["Wooden staff", "Druidic Focus", 500, ""], ["Yew wand", "Druidic Focus", 1000, ""], ["Amulet", "Holy Symbol", 500, ""], ["Emblem", "Holy Symbol", 500, ""], ["Holy Symbol", "Holy Symbol", 500, ""], ["Reliquary", "Holy Symbol", 500, ""], ["Potion of healing", "Potion", 5000, ""], ["Cure Wounds (1st Level)", "Spell", 1000, "Cures 1d8+5, single target"], ["Cure Wounds (2nd Level)", "Spell", 2000, "Cures 2d8+5, single target"], ["Cure Wounds (3rd Level)", "Spell", 3000, "Cures 3d8+5, single target"], ["Cure Wounds (4th Level)", "Spell", 4000, "Cures 4d8+5, single target"], ["Cure Wounds (5th Level)", "Spell", 5000, "Cures 5d8+5, single target"], ["Detect Poison and Disease", "Spell", 1000, ""], ["Lesser Restoration", "Spell", 2000, ""], ["Mass Cure Wounds", "Spell", 5000, "Cures 3d8+5 for each target, up to six targets"], ["Raise Dead", "Spell", 60000, ""], ["Remove Curse", "Spell", 3000, ""]]
    when "weapons"
      stock = [["Arrows (20)", "Ammunition", 100, ""], ["Blowgun needles (20)", "Ammunition", 100, ""], ["Crossbow bolts (20)", "Ammunition", 100, ""], ["Sling bullets (20)", "Ammunition", 4, ""], ["Chain mail", "Heavy Armor", 7500, ""], ["Plate", "Heavy Armor", 150000, ""], ["Ring mail", "Heavy Armor", 3000, ""], ["Splint", "Heavy Armor", 20000, ""], ["Leather", "Light Armor", 1000, ""], ["Padded", "Light Armor", 500, ""], ["Studded leather", "Light Armor", 4500, ""], ["Battleaxe", "Martial Melee Weapon", 1000, ""], ["Flail", "Martial Melee Weapon", 1000, ""], ["Glaive", "Martial Melee Weapon", 2000, ""], ["Greataxe", "Martial Melee Weapon", 3000, ""], ["Greatsword", "Martial Melee Weapon", 5000, ""], ["Halberd", "Martial Melee Weapon", 2000, ""], ["Lance", "Martial Melee Weapon", 1000, ""], ["Longsword", "Martial Melee Weapon", 1500, ""], ["Maul", "Martial Melee Weapon", 1000, ""], ["Morningstar", "Martial Melee Weapon", 1500, ""], ["Pike", "Martial Melee Weapon", 500, ""], ["Rapier", "Martial Melee Weapon", 2500, ""], ["Scimitar", "Martial Melee Weapon", 2500, ""], ["Shortsword", "Martial Melee Weapon", 1000, ""], ["Trident", "Martial Melee Weapon", 500, ""], ["War pick", "Martial Melee Weapon", 500, ""], ["Warhammer", "Martial Melee Weapon", 1500, ""], ["Whip", "Martial Melee Weapon", 200, ""], ["Breastplate", "Medium Armor", 40000, ""], ["Chain shirt", "Medium Armor", 5000, ""], ["Half plate", "Medium Armor", 75000, ""], ["Hide", "Medium Armor", 1000, ""], ["Scale mail", "Medium Armor", 5000, ""], ["Blowgun", "Ranged Weapon", 1000, ""], ["Hand Crossbow", "Ranged Weapon", 7500, ""], ["Heavy Crossbow", "Ranged Weapon", 5000, ""], ["Longbow", "Ranged Weapon", 5000, ""], ["Net", "Ranged Weapon", 100, ""], ["Shield", "Shield", 1000, ""], ["Club", "Simple Melee Weapon", 10, ""], ["Dagger", "Simple Melee Weapon", 200, ""], ["Greatclub", "Simple Melee Weapon", 20, ""], ["Handaxe", "Simple Melee Weapon", 500, ""], ["Javelin", "Simple Melee Weapon", 50, ""], ["Light Hammer", "Simple Melee Weapon", 200, ""], ["Mace", "Simple Melee Weapon", 500, ""], ["Quarterstaff", "Simple Melee Weapon", 20, ""], ["Sickle", "Simple Melee Weapon", 100, ""], ["Spear", "Simple Melee Weapon", 100, ""], ["Dart", "Simple Ranged Weapon", 50, ""], ["Light Crossbow", "Simple Ranged Weapon", 2500, ""], ["Shortbow", "Simple Ranged Weapon", 100, ""], ["Sling", "Simple Ranged Weapon", 1, ""]]
    end
    return adjust_prices(stock, rate)
  end # set_fix_stock()

  def set_rand_stock(type, rate)
    stock_options = ''
    case type
    when "general"
      stock_options = [] # No random stock
    when "magic"
      stock_options = []
    when "tavern"
      stock_options = []
      meals = [
        ["Stewed", "Roasted", "Fried", "Boiled", "Baked", "Grilled", "Seared", "Steamed", "Salted", "Pickled"],
        ["rabbit", "chicken", "duck", "mutton", "pork", "beef", "pheasant", "goose", "trout", "clams", "pork sausage", "duck sausage"],
        ["dumplings", "red cabbage", "white cabbage", "shredded cabbage", "leeks", "lentils", "broccoli", "peas", "cauliflower", "kidney beans", "string beans", "white beans", "turnip mash", "sliced turnips", "asparagus", "sprouts", "sweet peppers", "red potatoes", "golden potatoes", "yams"],
        ["carrots", "apples", "cherries", "tomatoes", "blueberries", "strawberries", "beets", "mushrooms", "radishes", "squash", "sweet onions", "red onions"],
        ["corn bread", "corn mash", "fresh bread", "crusty bread", "sesame bread", "oat bread", "pumpernickel bread", "pretzel bread", "fried egg", "bacon", "sharp cheese", "soft cheese"],
        ["water", "wheat ale", "porter", "mead", "white wine", "red wine", "sweet wine", "milk", "coffee", "brandy"]
      ]
      qualities = [
        ["Squalid", 3],
        ["Poor", 6],
        ["Modest", 30],
        ["Comfortable", 50],
        ["Wealthy", 80],
        ["Aristocratic", 200]
      ]
      50.times do
        q = qualities[rand(qualities.length)]
        stock_options.push ["#{q[0]} Meal", "Food", q[1].to_i, "#{meals[0][rand(meals[0].length)]} #{meals[1][rand(meals[1].length)]} with #{meals[2][rand(meals[2].length)]}, #{meals[3][rand(meals[3].length)]}, and a side of some #{meals[4][rand(meals[4].length)]}, accompanied by #{meals[5][rand(meals[5].length)]}"]
      end
    when "temple"
      stock_options = []
    when "weapons"
      stock_options = [] # No random stock
    end
    return adjust_prices(stock_options, rate)
  end # set_rand_stock()

  def set_rand_stock_qtt(type)
    case type
    when "general"
      return 0 # No random stock
    when "magic"
      return 5
    when "tavern"
      return 10
    when "temple"
      return 5
    when "weapons"
      return 0 # No random stock
    end
  end # set_rand_stock_qtt()

  def adjust_prices(stock, rate)
    rate = rate.to_f
    stock.each_with_index do |item, index|
      stock[index.to_i][2] = (item[2].to_i * rate).to_i
    end
    return stock
  end # adjust_prices()

  def set_buys(type)
    case type
    when "general"
      return "Jewels, gems and art pieces. This shop buys nothing magical"
    when "magic"
      return "Anything magical, as long as there is magic still in the object"
    when "tavern"
      return "" # Buys nothing from the player
    when "temple"
      return "" # Buys nothing from the player
    when "weapons"
      return "Weapons and armor of good quality, both mundane and magical"
    end
  end # set_buys()

  def set_limits(type)
    if type == "tavern"
      return [1000, 10000]
    else
      limits = [
        [75000, 150000],
        [100000, 200000],
        [150000, 300000]
      ]
      return limits[rand(3)]
    end
  end # set_limits()

end
