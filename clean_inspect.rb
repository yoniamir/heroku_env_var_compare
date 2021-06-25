# rubocop:disable all
# frozen_string_literal: true

require "active_support/concern"

module CleanInspect
  extend ActiveSupport::Concern

  included do
    def inspect
      instance_vars = self.instance_variables - @excluded_inspect_vars
      vars = instance_vars.map { |v| "#{v}=#{instance_variable_get(v).inspect}" }.join(", ")

      "<#{self.class}: #{vars}>"
    end
  end
end
