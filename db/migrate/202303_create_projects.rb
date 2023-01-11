class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    return if Rails.env.production?
    #
    # +---------------+--------------+------+-----+---------+----------------+
    # | Field         | Type         | Null | Key | Default | Extra          |
    #   +---------------+--------------+------+-----+---------+----------------+
    # | id            | bigint(20)   | NO   | PRI | NULL    | auto_increment |
    # | department_id | bigint(20)   | YES  | MUL | NULL    |                |
    # | first_name    | varchar(255) | YES  |     | NULL    |                |
    # | last_name     | varchar(255) | YES  |     | NULL    |                |
    # | salary        | int(11)      | YES  |     | NULL    |                |
    # +---------------+--------------+------+-----+---------+----------------+
    create_table :projects
    execute(%Q{
      ALTER TABLE `projects`
        ADD COLUMN `title` varchar(255) NULL,
        ADD COLUMN `start_date` date NULL,
        ADD COLUMN `end_date` date NULL,
        ADD COLUMN `budget` int NULL
    })
  end
end
