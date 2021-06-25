# frozen_string_literal: true

# Example:
# ruby compare_envs.rb freshly-demo freshly-qa

require 'pry'
require 'json'
require_relative 'heroku_env_config'


env_1_config = HerokuEnvConfig.new(ARGV[0].strip)
# env_2_config = HerokuEnvConfig.new(ARGV[1].strip)

binding.pry
puts "a"
