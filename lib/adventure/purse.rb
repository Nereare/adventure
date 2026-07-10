# frozen_string_literal: true

module Adventure
  # Represents a coin storage ingame.
  #
  # The base {Adventure::Purse} is capable of processing
  # only the four 10-based D&D default coins,
  # *i.e.*:
  #
  # - Copper Pieces (`100cp` = `1gp`);
  # - Silver Pieces (`10sp` = `1gp`);
  # - Gold Pieces (`gp`); and
  # - Platinum Pieces (`1pp` = `10gp`).
  class Purse
    # @!attribute [r]            cp
    #   @return   [Integer]      Copper pieces (`cp`).
    attr_reader :cp
    # @!attribute [r]            sp
    #   @return   [Integer]      Silver pieces (`sp`).
    attr_reader :sp
    # @!attribute [r]            gp
    #   @return   [Integer]      Gold pieces (`gp`).
    attr_reader :gp
    # @!attribute [r]            pp
    #   @return   [Integer]      Platinum pieces (`pp`).
    attr_reader :pp

    # Create a new instance of Purse.
    #
    # @param   opts  [Hash]   A list of parameters.
    # @option  opts  [Float]  :total  The `gp` equivalent of the {Purse} contents.
    def initialize(**opts)
      if opts.key?(:total)
        @cp, @sp, @gp, @pp = self.class.parse_total(opts[:total].to_f).values
      elsif opts.key?(:cp) || opts.key?(:sp) || opts.key?(:gp) || opts.key?(:pp)
        @cp = opts.key?(:cp) ? opts[:cp].to_i : 0
        @sp = opts.key?(:sp) ? opts[:sp].to_i : 0
        @gp = opts.key?(:gp) ? opts[:gp].to_i : 0
        @pp = opts.key?(:pp) ? opts[:pp].to_i : 0
      else
        @cp = 0
        @sp = 0
        @gp = 0
        @pp = 0
      end
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
