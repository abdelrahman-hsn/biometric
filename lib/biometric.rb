# frozen_string_literal: true

require_relative 'biometric/version'
require_relative 'biometric/configuration'
require_relative 'biometric/create'
require_relative 'biometric/check'

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
