class AddOrgToBaseModels < ActiveRecord::Migration[6.0]
  def change
    %i[customers flats flat_templates invoices reports tasks task_containers].each do |table|
      change_table table do |t|
        t.belongs_to :organization, null: false, on_delete: :cascade
      end
    end
  end
end
