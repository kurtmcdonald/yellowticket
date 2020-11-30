class AddQrCodeToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :qrcode, :string
  end
end
