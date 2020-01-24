class ChangeFirstNameAndLastNameTypo < ActiveRecord::Migration[6.0]
  def change
    rename_column :customers, :firstname, :first_name
    rename_column :customers, :lastname, :last_name
  end
end
