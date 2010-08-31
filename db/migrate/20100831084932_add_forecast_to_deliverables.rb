class AddForecastToDeliverables < ActiveRecord::Migration
  def self.up
    add_column :deliverables, :forecast, :decimal
  end
  
  def self.down
    remove_column :deliverables, :forecast
  end
end

