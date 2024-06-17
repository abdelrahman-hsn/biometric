# frozen_string_literal: true

class CreateBiometricKeys < ActiveRecord::Migration[7.1]
  def change
    create_table :biometric_keys do |t|
      t.references :keyable, polymorphic: true, null: false
      t.text :public_key
      t.string :device_id, null: false

      t.timestamps
    end

    add_index :biometric_keys, %i[keyable_id device_id], unique: true
  end
end
