require_dependency 'project'

module ProjectPatch
  def self.included(base) # :nodoc:
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)

    # Same as typing in the class 
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
      has_many :deliverables

      def ancestor_deliverables
        (deliverables + ancestors.map{|a| a.deliverables}.flatten).uniq 
      end
    end
  end
  
  module ClassMethods

  end
  
  module InstanceMethods
    def budget
      deliverables.map!{|d| d.budget}.sum
    end


    def leader
      return nil if members.empty?

      leaders = members.select{|m| m.roles.map{|r| r.name}.include? 'Lead Developer'}
      return leaders.first.user unless leaders.empty?

      return members.first.user
    end
  end    
end


