require_dependency 'issue'

# Patches Redmine's Issues dynamically.  Adds a relationship 
# Issue +belongs_to+ to Deliverable
module IssuePatch
  def self.included(base) # :nodoc:
    base.extend(ClassMethods)

    base.send(:include, InstanceMethods)

    # Same as typing in the class 
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
      belongs_to :deliverable
      after_save :update_time_entries

      def update_time_entries
        TimeEntry.update_all("deliverable_id = #{deliverable_id}", "issue_id = #{id}")
      end
    end

  end
  
  module ClassMethods
    
  end
  
  module InstanceMethods
    # Wraps the association to get the Deliverable subject.  Needed for the 
    # Query and filtering
    def deliverable_subject
      unless self.deliverable.nil?
        return self.deliverable.subject
      end
    end
  end    
end


