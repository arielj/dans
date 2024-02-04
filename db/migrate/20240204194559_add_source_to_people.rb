class AddSourceToPeople < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :source, :string, comment: "Source: Instagram/Ads/Another student/etc"
    add_index :people, :source
  end
end
