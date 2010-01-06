class AddInvoicedToDeliverables < ActiveRecord::Migration
  def self.up
    add_column :deliverables, :invoiced, :decimal
  end
  
  def self.down
    remove_column :deliverables, :invoiced
  end
end

