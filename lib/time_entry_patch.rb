require_dependency 'time_entry'

module TimeEntryPatch 
  def self.included(base) # :nodoc:
    # Same as typing in the class 
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
      belongs_to :deliverable
    end
  end
end



