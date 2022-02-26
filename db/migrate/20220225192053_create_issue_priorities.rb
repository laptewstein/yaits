class CreateIssuePriorities < ActiveRecord::Migration[5.2]
  def change
    return if Rails.env.production?

    # describe issue_priorities;
    # +------------+-------------+------+-----+---------+----------------+
    # | Field      | Type        | Null | Key | Default | Extra          |
    # +------------+-------------+------+-----+---------+----------------+
    # | id         | bigint(20)  | NO   | PRI | NULL    | auto_increment |
    # | created_at | datetime    | NO   |     | NULL    |                |
    # | updated_at | datetime    | NO   |     | NULL    |                |
    # | label      | varchar(32) | NO   | UNI | NULL    |                |
    # | value      | int(2)      | NO   |     | NULL    |                |
    # +------------+-------------+------+-----+---------+----------------+
    create_table :issue_priorities do |t|
      t.timestamps
    end
    execute(%Q{
      ALTER TABLE `issue_priorities`
        ADD COLUMN `label` varchar(32) NOT NULL UNIQUE,
        ADD COLUMN `value` int(2) NOT NULL,
        ADD UNIQUE KEY `index_on_label_and_value` (`label`, `value`)
    })
  end
end
