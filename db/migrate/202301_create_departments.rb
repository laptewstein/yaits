class CreateDepartments < ActiveRecord::Migration[5.2]
  def change
    return if Rails.env.production?
    #
    # describe disciplines;
    # +-------+--------------+------+-----+---------+----------------+
    # | Field | Type         | Null | Key | Default | Extra          |
    #   +-------+--------------+------+-----+---------+----------------+
    # | id    | bigint(20)   | NO   | PRI | NULL    | auto_increment |
    # | name  | varchar(255) | YES  |     | NULL    |                |
    # +-------+--------------+------+-----+---------+----------------+
    create_table :departments
    execute(%Q{
      ALTER TABLE `departments`
        ADD COLUMN `name` varchar(255) NULL
    })
  end
end
