class SaveDatetimeAndFrequencyOnTask < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE frequency AS ENUM ('never', 'daily', 'weekly', 'fort_nightly', 'monthly');
    SQL
    remove_column :tasks, :rrule
    add_column :tasks, :datetime, :datetime
    add_column :tasks, :frequency, :frequency
  end

  def down
    execute <<-SQL
      DROP TYPE frequency;
    SQL
    add_column :tasks, :rrule, :string
    remove_column :tasks, :datetime
    remove_column :tasks, :frequency
  end
end
