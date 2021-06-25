# rubocop:disable all
# frozen_string_literal: true

require_relative 'clean_inspect'

class HerokuEnvConfig
  include CleanInspect

  attr_reader :env_name, :config_string

  def initialize(env_name)
    @env_name = env_name
    @config_string = fetch_config_string
    @config = {}
    @excluded_inspect_vars = [:@config_string]
  end

  def config
    hash = {}
    keys = config_string.scan(/\n([A-Z0-9_]+):/).flatten
    keys.each do |key|
      hash[key] = ''
    end
    hash
  end

  private

  def fetch_config_string
    config_string = `heroku config -a #{env_name}`

    # Clean up
    config_string.gsub("=== #{env_name} Config Vars", '')
  end
end
