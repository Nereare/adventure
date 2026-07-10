# frozen_string_literal: true

module Adventure
  # Represents the world's time system.
  #
  # @deprecated   Maybe it will be implemented in the future.
  class Calendar
    DEFAULT_WEEKDAYS = %w[Firstday Secondday Thirdday Fourthday Fifthday Sixthday Seventhday Eighthday Ninthday Tenthday].freeze
    DEFAULT_MONTHS = {
      'Month One' => 28,
      'Month Two' => 28,
      'Month Three' => 28,
      'Month Four' => 28,
      'Month Five' => 28,
      'Month Six' => 28,
      'Month Seven' => 28,
      'Month Eight' => 28,
      'Month Nine' => 28,
      'Month Ten' => 28
    }.freeze
    DEFAULT_EPOCHS = {
      name: '',
      abbreviation: '',
      days: nil
    }.freeze

    # @!attribute [r]              hours_per_day
    #   @return   [Integer]        How many hours a day have.
    attr_reader :hours_per_day
    # @!attribute [r]              weekdays
    #   @return   [Array<String>]  The list of weekdays' names.
    attr_reader :weekdays
    # @!attribute [r]              months
    #   @return   [Hash]           The list of months's names.
    attr_reader :months
    # @!attribute [r]              epochs
    #   @return   [Hash]           The list of epochs' names and abbreviation.
    attr_reader :epochs
    # @!attribute [r]              calendar
    #   @return   [Array]          An Array with each day since year 1 as a Hash with day, month, year, and weekday.
    attr_reader :calendar

    # Create a new instance of Calendar.
    #
    # @param current_epoch   [Integer]                        The current epoch, as the index of the `epochs` Hash.
    # @param current_year    [Integer]                        The number of the current year.
    # @param current_month   [Integer]                        The current month, as the index of the `months` Array.
    # @param current_day     [Integer]                        The number of the current day.
    # @param    opts         [Hash]                           A list of optional parameters.
    # @option    opts        [Integer]        :hours_per_day  How many hours a day have.
    # @option    opts        [Array<String>]  :weekdays       The list of weekdays' names.
    # @option    opts        [Hash]           :months         The list of months's names, and days in each month.
    # @option    opts        [Hash]           :epochs         The list of epochs' names, abbreviation, and respective day count (or nil, if the current epoch).
    # @option    opts        [Array<Hash>]    :holidays       The list of holidays with date and name.
    def initialize(current_epoch, current_year, current_month, current_day, **opts)
      if opts.key?(:preset)
        case opts[:preset].strip.downcase
        when 'gregorian' then gregorian
        when 'harptos' then harptos
        else
          raise StandardError, 'No such preset calendar.'
        end
      else
        @hours_per_day = opts.key?(:hours_per_day) ? opts[:hours_per_day].to_i : 24
        @weekdays = opts.key?(:weekdays) ? opts[:weekdays].to_a : DEFAULT_WEEKDAYS
        @months = opts.key?(:months) ? opts[:months].to_h : DEFAULT_MONTHS
        @epochs = opts.key?(:epochs) ? opts[:epochs].to_h : DEFAULT_EPOCHS
        @holidays = opts.key?(:holidays) ? opts[:holidays].to_a : []
      end
      @today_index = parse_calendar(current_epoch, current_year, current_month, current_day)
    end

    # Return a String with the player's name, gender, species, and total level.
    #
    # @return         [String]        A String with the player's name, gender, species, and total level.
    def to_s
      "#{@name}, #{@gender.downcase} #{@species.downcase}, level #{@level}"
    end

    # Return an Integer as the current date's index in the `calendar`.
    #
    # @return         [Integer]       Current date's index.
    def to_i
      @today_index
    end

    # Return how many days a week have.
    #
    # @return         [Integer]       The number of days in a week.
    def days_per_week
      @weekdays.length
    end

    private

    def parse_calendar(_current_epoch, _current_year, _current_month, _current_day)
      @epochs.each_with_index do |epoch, epoch_index|
        #
      end
    end

    # Set calendar variables as Gregorian.
    def gregorian
      @hours_per_day = 24
      @weekdays = %w[
        Sunday
        Monday
        Tuesday
        Wednesday
        Thursday
        Friday
        Saturday
      ]
      @months = {
        'January' => 31,
        'February' => 28,
        'March' => 31,
        'April' => 30,
        'May' => 31,
        'June' => 30,
        'July' => 31,
        'August' => 31,
        'September' => 30,
        'October' => 31,
        'November' => 30,
        'December' => 31
      }
      @epochs = {
        -1 => {
          name: 'Before Common Era',
          abbreviation: 'BCE',
          days: 4000 * 365.25
        },
        0 => {
          name: 'Common Era',
          abbreviation: 'CE',
          days: nil
        }
      }
      @holidays = []
    end
  end
end
