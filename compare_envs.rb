# rubocop:disable all
# frozen_string_literal: true

# Example:
# ruby compare_envs.rb herokuapp1 herokuapp2

require 'pry'
require 'json'
require_relative 'heroku_env_config'

env1_config = HerokuEnvConfig.new(ARGV[0].strip);nil
env2_config = HerokuEnvConfig.new(ARGV[1].strip);nil

def compare_hashes(hash1, hash2)
  mismatched_keys = (hash1.keys + hash2.keys).uniq.reject { |k| hash1[k] == hash2[k] }
  mismatched_keys.each do |key|
    puts "key: #{key}"
    puts "hash1: #{hash1[key]}, hash2: #{hash2[key]}"
    puts ""
  end

  puts "Total #{mismatched_keys.size} mismatches."
end

compare_hashes(env1_config.config, env2_config.config)
