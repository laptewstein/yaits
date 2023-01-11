class CreateEmployees < ActiveRecord::Migration[5.2]
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
    create_table :employees do |t|
      t.references :department
    end
    execute(%Q{
      ALTER TABLE `employees`
        ADD COLUMN `first_name` varchar(255) NULL,
        ADD COLUMN `last_name` varchar(255) NULL,
        ADD COLUMN `salary` int NULL
    })
  end
end
