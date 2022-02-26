class CreateIssueStatuses < ActiveRecord::Migration[5.2]
  def change
    return if Rails.env.production?

    # describe issue_statuses;
    # +------------+-------------+------+-----+---------+----------------+
    # | Field      | Type        | Null | Key | Default | Extra          |
    # +------------+-------------+------+-----+---------+----------------+
    # | id         | bigint(20)  | NO   | PRI | NULL    | auto_increment |
    # | created_at | datetime    | NO   |     | NULL    |                |
    # | updated_at | datetime    | NO   |     | NULL    |                |
    # | label      | varchar(32) | NO   | UNI | NULL    |                |
    # +------------+-------------+------+-----+---------+----------------+
    create_table :issue_statuses do |t|
      t.timestamps
    end
    execute(%Q{
      ALTER TABLE `issue_statuses`
        ADD COLUMN `label` varchar(32) NOT NULL UNIQUE
    })
  end
end
