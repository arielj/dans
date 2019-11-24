# frozen_string_literal: true

class OldRecord < ActiveRecord::Base
  establish_connection :old_db
  self.abstract_class = true
end
