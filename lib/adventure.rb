# frozen_string_literal: true

require 'tty-exit'
require 'tty-option'

require_relative 'adventure/meta'
# require_relative 'adventure/loop'

# Gem's main module
module Adventure
  # CLI starter
  class Starter
    include Adventure
    include TTY::Exit
    include TTY::Option

    # List of all entity classes
    ADVENTURE_CLASSES = [].freeze

    # The one argument you really need: the filename of
    # the game
    option :gamefile do
      short  '-g'
      long   '--game=string'
      arity  1
      desc   'Name of the gamefile'
      optional
    end

    # Version flag
    option :version do
      short  '-v'
      long   '--version'
      desc   'Show current version of the interpreter'
    end

    # License flag
    option :license do
      short  '-l'
      long   '--license'
      desc   'Show license of the interpreter'
    end

    # Help flag
    option :help do
      short  '-h'
      long   '--help'
      desc   'Show this help text'
    end

    # Set help text
    usage do
      header Adventure::DESCRIPTION
      no_command
      footer "Available under the #{Adventure::LICENSE}."
    end

    # Run
    def run
      if params.errors.any?
        exit_with(:usage_error, params.errors.summary)
      else
        p = compiled_params
        case p
        when 'help' then puts help
        when 'license' then puts Adventure::LICENSE
        when 'version' then puts Adventure::VERSION
        else
          exit_with(:not_found, 'Given game file doesn\'t exist') unless File.file?(p)
          exit_with(:invalid_argument, 'Given game file isn\'t valid') unless gamefile_valid?(p)
          # TODO: Start main loop here
          puts p
        end
      end
    end

    private

    # Compile TTY::Option parameters into a single term
    def compiled_params
      p = params[:gamefile]
      p = 'version' if params[:version]
      p = 'license' if params[:license]
      p = 'help' if params[:help]

      p
    end

    # Check if the gamefile is valid YAML
    def gamefile_valid?(file)
      game = YAML.safe_load_file(file, permitted_classes: ADVENTURE_CLASSES)
      return false unless game.key?('current_room')
      return false unless game.key?('level')

      true
    end
  end
end
