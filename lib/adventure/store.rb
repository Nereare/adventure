# frozen_string_literal: true

module Adventure
  # Represents an ingame store.
  class Store
    # @!attribute [r]                title
    #   @return   [String]           The title/name of the shop.
    attr_reader :title
    # @!attribute [r]                subtitle
    #   @return   [String, nil]      The subtitle or flavor text of the shop, if any.
    attr_reader :subtitle
    # @!attribute [r]                quotes
    #   @return   [Array<String>]    A list of quotes to list as if said by the shop owner.
    attr_reader :quotes
    # @!attribute [r]                shop_type
    #   @return   [String]           A list of quotes to list as if said by the shop owner.
    attr_reader :shop_type

    # A list of generic quotes to fill if none are given.
    DEFAULT_QUOTES = [
      'Take your time, traveler. Good coin is always welcome here, no matter where it was minted.',
      'Ah, back from the wilds? You look like you\'ve seen some things—and like you need what I\'m selling.',
      'Quality is never cheap, friend, but it\'s always less expensive than replacing it out on the road.',
      'Look all you want, but remember: if you break it, you bought it. And my guards aren\'t known for their patience.',
      'The finest craftsmanship in the realm, right here under one roof! You won\'t find better prices from here to the capital.',
      'Step right up! Don\'t let the dust fool you; everything here is in perfect, working order.',
      'A wise coin spent now saves a drop of blood later. What catches your eye?',
      'I don\'t ask where you got that gold, and you don\'t ask where I got these goods. Do we have a deal?',
      'Mend it, replace it, or upgrade it—whatever your journey requires, I can provide.',
      'You get what you pay for around here. No haggling, no exceptions.',
      'The roads ahead are dangerous, stranger. It\'s best not to go empty-handed.',
      'Just arrived this morning from the eastern trade routes! Get it before the local garrison buys me out.',
      'Blessings of the hearth upon you. Have a look around, and let me know when you\'re ready to trade.'
    ].freeze

    # Possible types of stores.
    module ShopTypes
      # Generic shop type.
      GENERIC        = 'Generic'
      # Inn shop type.
      INN            = 'Inn'
      # Food & Drink shop type.
      FOOD_AND_DRINK = 'Food & Drink'
      # Weapon shop type.
      WEAPON         = 'Weapon'
      # Armor shop type.
      ARMOR          = 'Armor'
      # Weapon & Armor shop type.
      WEAPON_ARMOR   = 'Weapon & Armor'
      # Magical shop type.
      MAGICAL        = 'Magical'
      # Other shop type.
      OTHER          = 'Other'
    end

    # Create a new instance of Store.
    #
    # @param   opts  [Hash]   A list of parameters.
    # @option  opts  [Float]  :total  The `gp` equivalent of the {Purse} contents.
    def initialize(title, shop_type, stock = nil, **opts)
      # Mandatory parameters:
      @title     = title.strip
      @shop_type = shop_type.strip
      @stock     = stock
      # Parse stock given:
      @stock.filter! { |i| i.is_a? Adventure::Item } # Remove non-Item elements.
      @stock     = [] if @stock.nil? || @stock.empty? # If no Items or nil as stock, fill with EMPTY stock.
      # Optional and not-quite-optional parameters:
      @subtitle  = opts.key?(:subtitle) ? opts[:subtitle].strip : ''
      @buys      = opts.key?(:buys) ? opts[:buys] : false
      @sells     = opts.key?(:sells) ? opts[:sells] : true
      @quotes    = opts.key?(:quotes) ? opts[:quotes].to_a : DEFAULT_QUOTES
    end

    # Gets a Float equivalent of `gp`s based on the current
    # contents of this {Purse}.
    #
    # @return   [Float]   A floating-point equivalent of `gp`s.
    def gp_equivalent
      total = @cp / 100.00
      total += @sp / 10.0
      total += @gp
      total += @pp * 10
      total
    end

    # Alias for {::gp_equivalent}
    #
    # @return   [Float]   A floating-point equivalent of `gp`s.
    def to_f
      gp_equivalent
    end

    # The {Purse}'s contents as a string of each coins'
    # quantities.
    #
    # @return   [String]  A String of each correspondent quantity of `cp`s, `sp`s, `gp`s, and `pp`s.
    def to_s
      "#{@cp}cp #{@sp}sp #{@gp}gp #{@pp}pp"
    end

    # The {Purse}'s contents as an array of each coins'
    # quantities.
    #
    # @return   [Array]   An Array containing the quantities, in this order, of `cp`s, `sp`s, `gp`s, and `pp`s.
    def to_a
      [@cp, @sp, @gp, @pp]
    end

    # The {Purse}'s contents as a hash of each coins'
    # quantities.
    #
    # @return   [Hash]    A Hash containing the quantities of `cp`s, `sp`s, `gp`s, and `pp`s, each under the equivalent Symbol (*e.g.* `:sp`).
    def to_h
      { cp: @cp, sp: @sp, gp: @gp, pp: @pp }
    end

    # Charge a given quantity from this {Purse}.
    #
    # @param    debt    [Float, Hash]   Either a Float of the `gp` equivalent of the debt, or a Hash of each coin to be charged.
    # @raise    [StandardError]         Throws an error if either the {Purse} doesn't have enough to pay the given debt, or if the given debt is neither a Float or a Hash.
    def charge(debt)
      # Get total equivalent in `gp`s.
      money = gp_equivalent

      # Parse given debt according to its type.
      if debt.is_a? Hash
        debt = self.class.parse_coins(**debt)
      elsif debt.is_a? Numeric
        debt = debt.to_f
      else
        raise StandardError, 'Invalid debt.'
      end
      # Raise an error if the money is insuficient to pay
      # the debt.
      raise StandardError, 'Insuficient money error.' if money < debt

      # If the money is suficient, begin charging.
      new_money = money - debt
      @cp, @sp, @gp, @pp = self.class.parse_total(new_money).values
    end

    # Adds a given quantity to this {Purse}.
    #
    # @param    credit  [Float, Hash]   Either a Float of the `gp` equivalent of the credit, or a Hash of each coin to be credited.
    # @raise    [StandardError]         Throws an error if the given credit is neither a Float or a Hash.
    def receive(credit)
      # Parse given credit according to its type
      if credit.is_a? Hash
        @cp += credit.key?(:cp) ? credit[:cp].to_i.abs : 0
        @sp += credit.key?(:sp) ? credit[:sp].to_i.abs : 0
        @gp += credit.key?(:gp) ? credit[:gp].to_i.abs : 0
        @pp += credit.key?(:pp) ? credit[:pp].to_i.abs : 0
      elsif credit.is_a? Numeric
        new_cp, new_sp, new_gp, new_pp = self.class.parse_total(credit).values.map(&:abs)
        @cp += new_cp
        @sp += new_sp
        @gp += new_gp
        @pp += new_pp
      else
        raise StandardError, 'Invalid credit.'
      end
    end

    # Turn Gold Pieces (`gp`) equivalent to Hash of
    # each lesser and greater coins.
    #
    # While there are **many** ways to turn a `gp`
    # equivalent to each of the four basic D&D coins,
    # this method assumes the minimum of each of the lesser
    # coins (`cp`, `sp`, and `gp`), and all the remainder
    # of the value being represented in `pp`s.
    #
    # @param  total   [Float]   A floating-point `gp` equivalent.
    # @return         [Hash]    A Hash of quantities of `cp`s, `sp`s, `gp`s, and `pp`s.
    def self.parse_total(total)
      cp  = (total * 100).to_i
      sp  = cp / 10
      cp -= sp * 10
      gp  = sp / 10
      sp -= gp * 10
      pp  = gp / 10
      gp -= pp * 10
      { cp: cp, sp: sp, gp: gp, pp: pp }
    end

    # Turn the given coins quantities in their corresponding
    # `gp` equivalent.
    #
    # @param    args  [Hash]            A Hash with each coin quantity.
    # @option   args  [Integer]   :cp   The quantity of Copper Pieces.
    # @option   args  [Integer]   :sp   The quantity of Silver Pieces.
    # @option   args  [Integer]   :gp   The quantity of Gold Pieces.
    # @option   args  [Integer]   :pp   The quantity of Platinum Pieces.
    def self.parse_coins(**args)
      cp = args.key?(:cp) ? args[:cp].to_f : 0.0
      sp = args.key?(:sp) ? args[:sp].to_f : 0.0
      gp = args.key?(:gp) ? args[:gp].to_f : 0.0
      pp = args.key?(:pp) ? args[:pp].to_f : 0.0

      total  = gp
      total += cp / 100.0
      total += sp / 10.0
      total += pp * 10.0

      total
    end
  end
end
