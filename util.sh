#!/usr/bin/env bash
clear

rm -vf adventure*.gem
yes | gem uninstall adventure

bundle

gem build *.gemspec
gem install adventure-*.gem

clear
