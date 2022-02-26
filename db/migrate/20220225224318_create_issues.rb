class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    return if Rails.env.production?

    # describe issues;
    # +-------------------+--------------+------+-----+---------+----------------+
    # | Field             | Type         | Null | Key | Default | Extra          |
    # +-------------------+--------------+------+-----+---------+----------------+
    # | id                | bigint(20)   | NO   | PRI | NULL    | auto_increment |
    # | created_at        | datetime     | NO   |     | NULL    |                |
    # | updated_at        | datetime     | NO   |     | NULL    |                |
    # | title             | varchar(191) | NO   | UNI | NULL    |                |
    # | description       | text         | YES  |     | NULL    |                |
    # | issue_priority_id | int(11)      | YES  |     | NULL    |                |
    # | issue_status_id   | int(11)      | YES  |     | NULL    |                |
    # | discipline_id     | int(11)      | YES  |     | NULL    |                |
    # +-------------------+--------------+------+-----+---------+----------------+
    create_table :issues do |t|
      t.timestamps
    end
    execute(%Q{
      ALTER TABLE `issues`
        ADD COLUMN `title` varchar(191) NOT NULL UNIQUE,
        ADD COLUMN `description` text,
        ADD COLUMN `issue_priority_id` int(11),
        ADD COLUMN `issue_status_id` int(11),
        ADD COLUMN `discipline_id` int(11)
    })
  end
end
