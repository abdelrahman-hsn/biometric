# frozen_string_literal: true

module Biometric
  # Create class for handling biometric Createing
  class Create
    def self.call(biometric_key_params, keyable)
      existing_biometric = existing_biometric_key(biometric_key_params, keyable)
      if existing_biometric.present?
        if existing_biometric.public_key == biometric_key_params[:biometric_key][:public_key]
          return error_response('Biometric key for device already exists')
        end

        existing_biometric.update!(public_key: biometric_key_params[:biometric_key][:public_key])

        return success_response
      end

      create_new_biometric_key(biometric_key_params(biometric_key_params), keyable)
    end

    def self.biometric_key_params(params)
      params.require(:biometric_key).permit(:device_id, :public_key)
    end

    def self.existing_biometric_key(biometric_key_params, keyable)
      keyable.biometric_keys.find_by(device_id: biometric_key_params[:biometric_key][:device_id])
    end

    def self.create_new_biometric_key(biometric_key_params, keyable)
      biometric_key = keyable.biometric_keys.new(biometric_key_params)
      return error_response(biometric_key.errors.full_messages.join(', ')) unless biometric_key.save

      success_response
    end

    def self.success_response
      { success: true }
    end

    def self.error_response(message)
      { success: false, error: message }
    end
  end
end
