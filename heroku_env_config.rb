# rubocop:disable all
# frozen_string_literal: true

require_relative 'clean_inspect'

class HerokuEnvConfig
  include CleanInspect

  attr_reader :env_name, :config_string, :config

  def initialize(env_name)
    @env_name = env_name
    @config_string = fetch_config_string
    @config = config_hash
    @excluded_inspect_vars = [:@config_string]
  end

  private

  def config_hash
    hash = {}

    keys = config_string.scan(/\n([A-Z0-9_]+):/).flatten
    keys_except_last = keys[0..-2]

    keys_except_last.each do |key|
      puts key
      regex = /\n#{key}: +(.*)\n([A-Z0-9_]+):/
      value = config_string.match(regex)[1]
      hash[key] = value
    end

    hash
  end

  def fetch_config_string
    config_string = `heroku config -a #{env_name}`

    # Clean up
    config_string.gsub("=== #{env_name} Config Vars", '')
  end
end
