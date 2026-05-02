# frozen_string_literal: true

require 'tty-exit'
require 'tty-option'

require_relative 'adventure/being'
require_relative 'adventure/inventory'
require_relative 'adventure/item'
require_relative 'adventure/meta'
require_relative 'adventure/player'
require_relative 'adventure/purse'
require_relative 'adventure/world'

# Gem's main module.
module Adventure
  # CLI starter.
  class Starter
    include Adventure
    include TTY::Exit
    include TTY::Option

    # List of all entity classes.
    ADVENTURE_CLASSES = [].freeze

    # The one argument you really need: the filename of
    # the game.
    option :gamefile do
      short  '-g'
      long   '--game=string'
      arity  1
      desc   'Name of the gamefile'
      optional
    end

    # Version flag.
    flag :version do
      short  '-v'
      long   '--version'
      desc   'Show current version of the interpreter'
    end

    # License flag.
    flag :license do
      short  '-l'
      long   '--license'
      desc   'Show license of the interpreter'
    end

    # Help flag.
    flag :help do
      short  '-h'
      long   '--help'
      desc   'Show this help text'
    end

    # Set help text.
    usage do
      header Adventure::DESCRIPTION
      no_command
      footer "Available under the #{Adventure::LICENSE}."
    end

    # Begin CLI checks and calls the adequate methods.
    def run
      if params.errors.any?
        exit_with(:usage_error, params.errors.summary)
      else
        p = compiled_params
        case p
        when 'help' then puts help
        when 'license' then puts Adventure::LICENSE
        when 'version' then puts Adventure::VERSION
        when 'gamefile'
          file = params[:gamefile]
          exit_with(:not_found, 'Given game file doesn\'t exist') unless File.file?(file)
          exit_with(:invalid_argument, 'Given game file isn\'t valid') unless gamefile_valid?(file)
          # TODO: Start main loop here
          puts p
        else
          exit_with(:invalid_argument, 'Unexpected arguments')
        end
      end
    end

    private

    # Compile TTY::Option parameters into a single term for action checking.
    def compiled_params
      p = nil
      p = 'version' if params[:version]
      p = 'license' if params[:license]
      p = 'help' if params[:help]
      p = 'gamefile' unless params[:gamefile].nil? || params[:gamefile].empty?

      p
    end

    # Check if the gamefile has minimal contents expected.
    #
    # @param  file  [String]  The file name given through CLI.
    def gamefile_valid?(file)
      game = YAML.safe_load_file(file, permitted_classes: ADVENTURE_CLASSES)
      return false unless game.key?('current_room')
      return false unless game.key?('level')

      true
    end
  end
end
