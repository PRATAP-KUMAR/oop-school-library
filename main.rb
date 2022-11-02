#! /usr/bin/ruby

require './app'

def main
  app = App.new
  app.welcome_message
  app.message
  app.logic
end

main
