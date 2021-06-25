# frozen_string_literal: true

# Example:
# ruby compare_envs.rb freshly-demo freshly-qa

require 'pry'
require 'json'
require_relative 'heroku_env_config'

env1_config = HerokuEnvConfig.new(ARGV[0].strip);nil
env2_config = HerokuEnvConfig.new(ARGV[1].strip);nil

def compare_hashes(hash1, hash2)
  hash1.keys.reject do |k|
    hash1[k] == hash2[k]
  end
end

compare_hashes(env1_config.config, env2_config.config)
