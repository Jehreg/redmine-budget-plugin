class AddTimeEntryUpdateTriggerToIssues < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      CREATE TRIGGER update_time_entry_deliverable AFTER UPDATE ON issues
      FOR EACH ROW 
      BEGIN
        IF NEW.deliverable_id <> OLD.deliverable_id THEN
          UPDATE time_entries 
          SET deliverable_id = NEW.deliverable_id
          WHERE time_entries.issue_id = NEW.id;
        END IF;
      END;
    SQL
  end

  def self.down
    execute <<-SQL
      DROP TRIGGER issues.update_time_entry_deliverable
    SQL
  end
end
