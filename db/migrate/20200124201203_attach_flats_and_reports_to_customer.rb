class AttachFlatsAndReportsToCustomer < ActiveRecord::Migration[6.0]
  def change
    remove_belongs_to :flats, :task, foreign_key: true
    remove_belongs_to :reports, :task, foreign_key: true

    add_belongs_to :flats, :customer, foreign_key: true
    add_belongs_to :reports, :customer, foreign_key: true


  end
end
