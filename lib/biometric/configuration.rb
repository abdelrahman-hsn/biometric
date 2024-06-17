# frozen_string_literal: true

module Biometric
  # Biometric Configuration
  class Configuration
    attr_accessor :secret_key

    def initialize
      @secret_key = nil
    end
  end
end
