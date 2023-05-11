require "date"

class Adventure
  attr_reader :name, :create, :year, :level, :type, :intro, :plot, :author
  attr_reader :version, :settlement

  def initialize(start_type = "city", start_level = 1, cow = false)
    creation = DateTime.now
    @name    = "Random Adventure " + creation.strftime("%Y%m%d%H%M%S%L")
    @create  = creation.strftime("%A, %B %-d, %Y")
    @year    = creation.strftime("%Y")
    @level   = set_level(start_level.to_i)
    @type    = set_type(start_type)
    @intro   = set_intro(@type)
    @plot    = set_plot(cow)

    @author  = "Solo Adventure Generator"
    @version = "0.8.3"

    @settlement = Settlement.new(@plot)
  end

  private

  def set_level(level)
    if level <= 20 and level >= 1
      return level
    else
      return 1
    end
  end # set_level()

  def set_type(type)
    types = [
      "city",
      "dungeon"
    ]
    if types.include? type
      # return type
      return "city"
    else
      # return types[rand(types.length)]
      # For now the dungeon type will not be implemented, so we use only "city"
      return "city"
    end
  end # set_type()

  def set_intro(type)
    intro = Array.new(3)

    case type
    when "dungeon"
      # Dungeon Start
      dungeon_scene = [
        "a rat scuttles past carrying a finger bone with a ring on it.",
        "you hear a card game going on in the next room. It sounds like someone is losing their shirt.",
        "a sleepy orc pushes you to one side and says &quot;Otta ma way cur. Yer blocking the way.&quot;",
        "a voice screams from ahead.",
        "blood drips from a hole in the ceiling and pools on the floor.",
        "your hear the sound of a whip crack from up ahead.",
        "you find a room of corpses. One has a hand outstretched towards something that isn"t there anymore. A second has stabbed the first in the back with a dagger.",
        "a paper boat floats past on an underground stream. If plucked from the water is has a letter written inside, the water damaged the words beyond readability, however.",
        "a prisoner in a cage sees the party and whimps weakly &quot;turn back! Runaway!&quot; before stopping to breathe.",
        "cave paintings cover one of the walls, obviously the work of bored hands.",
        "a side corridor has an activated deadly trap. It doesn"t seem like it can reactivate without resetting.",
        "a grate in the wall allows you to see a mimic finish consuming an adventurer and scuttle off.",
        "wind howls mournfully as you cross a rope bridge strewn with arrow riddled adventurers.",
        "a hunchbacked orc with his back to you tinkers with something in the wall and complains loudly in a language you do not understand. It is harmless and doesn"t notice you.",
        "a large man sits near a pile of treasure reading a book. If approached he changes into a wisp of smoke, together with all the treasure, and retreats to a lamp. Any amount of rubbing on the lamp produces only &quot;Go away! We"re closed!&quot;",
        "a displacer beast and blink dog come thrashing through a cross corridor, then both vanish into the Ether.",
        "a dead man"s ghost continues searching for a key to a door. A long dead rogue lies nearby.",
        "a grouchy dragon stomps around the cave entrance shouting &quot;Igor! Where"s the ledger listing my gold coins?!&quot; then flies away shouting still &quot;You cannot hide from me, Igor!&quot;",
        "a dusty side corridor holds a tiny, rough made shrine to an unlikely god, and a dusty body with it"s hands still clasped in prayer.",
        "a hole broken in the brick walls leads to a very, very dark tunnel."
      ]

      intro[0] = "After a tenday of uneventful travel, you arrive at a dungeon entrance, #{dungeon_scene[rand(20)]}"
      intro[1] = "The entrance is #{["un", ""][rand(0..1)]}lit, and you find yourself drawn to it."
      intro[2] = "Enter the dungeon"
    else
      # City Start
      village_scene = [
        [ # Idyllic version
          "a farmer and his son walk past on the road. The man is teaching his son a song",
          "a woodcutter pauses his chopping to wave at you as you pass",
          "a milkman struggles past pulling a horse cart. If questioned he mentions that his horse has taken ill but he"s managing",
          "a farm wife sets a pie on a windowsill to cool while you walk by",
          "a gaggle of children discusses plans to nick a pie from a windowsill",
          "a butcher haggles cheerfully with a farmer over the price of a fat cow",
          "a group of women takes turns sharing gossip and hoisting buckets from the town well",
          "a celebration is taking place on the town green for two young people, recently married",
          "a farmer is having a yard sale and has piled a small mountain of junk outside his home",
          "a healthy-looking dog runs past with a laughing boy in pursuit",
          "a farm wife watches playing children through an open window",
          "a man is helping a peddler fix his broken-down wagon on the roadside",
          "a smith pounds furiously on his anvil but stops to smile when his wife brings him some water",
          "a group of old men with long beards sit on a stoop, smoking pipes",
          "a baker is returning home from making his rounds delivering bread",
          "The town priest stands outside his church greeting people as they arrive for the service. He invites the PCs to attend",
          "a group of men is mending a broken fence",
          "a fisherman walks past carrying tackle on his way down to the lake",
          "a peddler is selling simple wares to the villagers from his wagon on the town green",
          "a group of dwarves with brightly colored hoods puff pipes on the inn porch and watch the sunset"
        ],
        [ # Rotting version
          "a group of dogs chewing on fallen guardsmen after a street battle",
          "a giant spider, seen out of the corner of your eye, pulls a struggling something back into a dark alley",
          "a group of beggars in rags huddle together for warmth against the chill of the winter morning",
          "a man and a women, speaking to a stone carver about what to put on their child"s headstone",
          "a burned-out drug den with charred corpses outside and city guards keeping gawkers away",
          "a man doling out rations inside a besieged city. Only those able to fight still get full portions",
          "a carriage passing through a rutted street with armed guards and a dangerous-looking wizard riding shotgun",
          "a tailor trying hopelessly to impress a noblewoman with a variety of dresses, all of which she scoffs at",
          "a gang of ruffians scoping out potential victims. They give you a nod of acknowledgment, one predator to another",
          "a strumpet with a face like a raccoon checks you out, then resignedly starts walking towards you while putting on a fake smile",
          "a group of guards escorts a morose prisoner to the gallows",
          "a group of crows flies away from several bodies hanging at the gallows when people approach",
          "a group of elves passes by you, holding handkerchiefs to their noses",
          "a leper approaches you and starts begging for alms",
          "The king"s guard execute a man in the street for a petty crime",
          "a passing wagon hits a puddle and sprays you with vile mud",
          "a carriage tramples a club-footed beggar who was too slow to move out of the way",
          "a loan shark approaches you to make an offer",
          "a thick fog rolls in covering the city in a damp mist",
          "a church bell sounds mournful, it"s ring swallowed up by the fog"
        ],
        [ # Neutral version
          "the wooden buildings seem to be still wet from the last rain",
          "a group of children runs past you, playing catch",
          "a local produce seller can be heard calling out for clients",
          "some clouds in the otherwise clear sky",
          "the local square is dotted with a few peasants browsing the displays",
          "nearby you see two cats playing with each other over a roof",
          "you smell the scent of warm bread out of the oven from a nearby building",
          "an old lady on a rocking chair talks absentmindedly to her grandchildren as they watch you enter the village",
          "you are accompanied into the village by a cart from a nearby farm, loaded with produce to sell",
          "an aristocrat leaves his coach and frowns deeply at the sight of the local inn",
          "a group of fishermen boards a boat into the local lake, loaded with nets and fish poles",
          "you are caught by surprise by a strong wind blowing from the neighbooring wheat fields which blows for a minute or two and then stops, the locals don"t seem to mind this at all",
          "a group of coal-covered miners are entering the village through an adjacent street, their faces worn by labor",
          "foo",
          "foo",
          "foo",
          "foo",
          "foo",
          "foo",
          "foo"
        ]
      ]
      village_adj = [
        "a cozy little",
        "a decadent",
        "an isolated"
      ]

      village_type = rand(3)
      intro[0] = "After a few days of uneventful travel, you arrive at #{village_adj[village_type]} village, #{village_scene[village_type][rand(20)]}."
      intro[1] = "You also notice, near a building larger than the rest, a notice board that very few people stop to gaze at, and the very few that do are either large and brawny or desperate-looking."
      intro[2] = "Enter the village"
    end

    return intro
  end # set_intro()

  def set_plot(cow)
    plot = ""
    if cow
      plot = "cow"
    else
      plots = [
        "dragon",     # A dragon is threatening the countryside.
        "wizard",     # A mad wizard is seeking to conquer the kingdom.
        "cultists",   # A group of devil-worshiping cultists are seeking to summon their evil lord.
        "undead",     # Undead are threatening your world.
        "cow"         # A cow is your nemesis!
      ]
      case rand(10) # Since the Cow plot is a special kind, it will have only a 10% chance.
      when 0..9
        plot = plots[rand(0..3)]
      else
        plot = plots[4]
      end
    end
    return plot
  end # set_plot()

end
