class CreateMicrositePayments < ActiveRecord::Migration
  def self.up
    create_table :microsite_payments do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :microsite_payments
  end
end
