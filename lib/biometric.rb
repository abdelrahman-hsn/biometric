# frozen_string_literal: true

require_relative 'biometric/version'
require_relative 'biometric/configuration'

# Biometric gem
module Biometric
  class Error < StandardError; end

  def self.configure
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
