class AddInvitableToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      ## Invitable
      t.string   :invitation_token, unique: true
      t.datetime :invitation_created_at
      t.datetime :invitation_sent_at
      t.datetime :invitation_accepted_at
      t.integer  :invitation_limit
      t.integer  :invited_by_id
      t.string   :invited_by_type
    end

    # Remove confirmable
    remove_column :users, :confirmation_token, :string
    remove_column :users, :confirmed_at, :datetime
    remove_column :users, :confirmation_sent_at, :date
    remove_column :users, :unconfirmed_email, :string
  end
end
