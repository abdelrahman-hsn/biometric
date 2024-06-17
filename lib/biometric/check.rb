# frozen_string_literal: true

require 'openssl'
require 'base64'

# Biometric module
module Biometric
  # Check class for handling biometric checks
  class Check
    def self.call(params, keyable_model)
      device_id, signature, keyable = extract_params(params, keyable_model)
      return error_response('Device ID and Signature are required') unless device_id && signature
      return error_response('keyable not found') unless keyable

      biometric_key = find_biometric_key(keyable, device_id)
      return error_response('Biometric key not found for the specified device') unless biometric_key

      verify_signature(biometric_key, signature, keyable)
    end

    def self.extract_params(params, keyable_model)
      [params[:device_id], params[:signature], keyable_model.find(params[:keyable_id])]
    end

    def self.find_biometric_key(keyable, device_id)
      keyable.biometric_keys.find_by(device_id: device_id)
    end

    def self.verify_signature(biometric_key, signature, keyable)
      public_key = OpenSSL::PKey::RSA.new(Base64.decode64(biometric_key.public_key))
      payload = keyable.id.to_s + Biometric.configuration.secret_key

      signature_verified = verify_with_rescue(public_key, signature, payload)
      signature_verified ? success_response : error_response('not_found')
    end

    def self.verify_with_rescue(public_key, signature, payload)
      public_key.verify(OpenSSL::Digest.new('SHA256'), Base64.decode64(signature), payload)
    rescue OpenSSL::PKey::RSAError
      error_response('Invalid public key format')
    end

    def self.success_response
      { success: true }
    end

    def self.error_response(message)
      { success: false, error: message }
    end
  end
end
