# rubocop:disable all
# frozen_string_literal: true

# Example:
# ruby compare_envs.rb herokuapp1 herokuapp2

require 'pry'
require 'json'
require_relative 'heroku_env_config'

puts "Comparing #{ARGV[0]} to #{ARGV[1]}..."

env1_config = HerokuEnvConfig.new(ARGV[0]);nil
env2_config = HerokuEnvConfig.new(ARGV[1]);nil

def compare_hashes(env1, env2)
  mismatched_keys = (env1.config.keys + env2.config.keys).uniq.reject { |k| env1.config[k] == env2.config[k] }
  mismatched_keys.each do |key|
    puts "key: #{key}"
    puts "#{env1.env_name}: #{env1.config[key]}"
    puts "#{env2.env_name}: #{env2.config[key]}"
    puts ""
  end

  puts "Total #{mismatched_keys.size} mismatches."
end

compare_hashes(env1_config, env2_config)
