# frozen_string_literal: true

class HerokuEnvConfig
  attr_reader :env_name, :config_string

  def initialize(env_name)
    @env_name = env_name
    @config_string = fetch_config_string
    @config = {}
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
