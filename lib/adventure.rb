# frozen_string_literal: true

require 'tty-exit'
require 'tty-option'

require_relative 'adventure/meta'

# Gem's main module
module Adventure
  # Game starter
  class Starter
    include Adventure
    include TTY::Exit
    include TTY::Option

    # The one argument you really need: the filename of
    # the game
    argument :gamefile do
      name   'gamefile'
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
      header "#{Adventure::DESCRIPTION}"
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
          # TODO: Start main loop here
          puts p.to_s
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
  end
end
