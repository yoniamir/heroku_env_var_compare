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
    last_key = nil
    key_value_regex = /([A-Z0-9_]+): +(.*)/

    config_array = config_string.split("\n").reject { |c| c.empty? }
    config_array.each do |config_row|
      puts config_row
      match = config_row.match(key_value_regex)

      if match
        key = match[1]
        value = match[2]
        hash[key] = value
        last_key = key
      else
        hash[last_key] += "\n" + config_row
      end
    end

    hash
  end

  def fetch_config_string
    config_string = `heroku config -a #{env_name}`

    # Clean up
    config_string.gsub("=== #{env_name} Config Vars", '')
  end
end
