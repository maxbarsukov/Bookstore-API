class RemoveAgeFromAuthor < ActiveRecord::Migration[6.1]
  def change
    remove_column :authors, :age, :integer
  end
end
