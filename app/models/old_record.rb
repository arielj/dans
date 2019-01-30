class OldRecord < ActiveRecord::Base
  establish_connection :old_db
  self.abstract_class = true
end
