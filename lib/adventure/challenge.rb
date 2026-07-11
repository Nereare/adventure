# frozen_string_literal: true

require 'uuid'

module Adventure
  # Represents an ingame challenge and/or check.
  class Challenge
    # @!attribute [r]              name
    #   @return   [String]         A name or alias for the challenge.
    attr_reader :name
    # @!attribute [r]              dc
    #   @return   [Integer]        Difficulty Class (DC).
    attr_reader :dc
    # @!attribute [r]              skill
    #   @return   [String]         Which Skill (or Ability, or Saving Throw, or whatever) to roll for.
    attr_reader :skill

    # Create a new instance of Challenge
    def initialize(dc, skill, **opts)
      @name    = opts.key?(:name) ? opts[:name].strip : UUID.new.generate
      @dc      = dc.to_i
      @skill   = skill.strip
      @success = nil
      raise StandardError, 'All minimal texts must be set.' unless opts.key?(:challenge_text) && opts.key?(:challenge_inline) && opts.key?(:challenge_button) && opts.key?(:success_text) && opts.key?(:success_inline) && opts.key?(:failure_text) && opts.key?(:failure_inline)

      @challenge_text   = opts[:challenge_text].strip
      @challenge_inline = opts[:challenge_inline].strip
      @challenge_button = opts[:challenge_button].strip
      @success_text     = opts[:success_text].strip
      @success_inline   = opts[:success_inline].strip
      @failure_text     = opts[:failure_text].strip
      @failure_inline   = opts[:failure_inline].strip
    end

    # Either the {Challenge}'s challenge inline text if unrolled, or inline result text if rolled.
    #
    # An alias for {#text} with `true` as parameter.
    #
    # @return   [String]  A String of either the inline challenge text or the inline result text.
    # @see      #text
    def to_s
      text inline: true
    end

    # Either the {Challenge}'s challenge text if unrolled, or result text if rolled.
    #
    # @param    inline    [Boolean]   Whether to return the inline text or the full text. Defaults to full text (*i.e.* `false`)
    # @return             [String]    A String of either the challenge or the result.
    def text(inline: false)
      if @success.nil?
        inline ? @challenge_inline : @challenge_text
      elsif @success
        inline ? @success_inline : @success_text
      else
        inline ? @failure_inline : @failure_text
      end
    end

    # The query to show as an action / option to the player.
    #
    # @return   [String]  The query / action text to show to the player.
    def button
      @challenge_button
    end

    # The {Challenge}'s Difficulty Class (DC).
    #
    # @return   [Integer] The chcallenges DC - even if rolled already.
    def to_i
      @dc
    end

    # Whether or not the {Challenge} was succeeded, or `nil` if untried.
    #
    # @return   [Boolean,nil]   `nil` if unrolled, otherwise `true` if succeeded or `false` if not.
    def success?
      @success
    end

    # Whether or not the {Challenge} is unrolled.
    #
    # @return   [Boolean]       `true` if not rolled for, `false` otherwise.
    def unrolled?
      @success.nil?
    end

    # Roll for the {Challenge} and save success or failure to the object.
    #
    # @param    roll  [Integer] The result of the player's roll.
    # @return         [Boolean] `true` if success, `false` otherwise.
    def roll(roll)
      @success = roll >= @dc
      @success
    end
  end
end
