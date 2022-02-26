class CreateDisciplines < ActiveRecord::Migration[5.2]
  def change
    return if Rails.env.production?
    #
    # describe disciplines;
    # +------------+-------------+------+-----+---------+----------------+
    # | Field      | Type        | Null | Key | Default | Extra          |
    # +------------+-------------+------+-----+---------+----------------+
    # | id         | bigint(20)  | NO   | PRI | NULL    | auto_increment |
    # | created_at | datetime    | NO   |     | NULL    |                |
    # | updated_at | datetime    | NO   |     | NULL    |                |
    # | label      | varchar(32) | NO   | UNI | NULL    |                |
    # +------------+-------------+------+-----+---------+----------------+
    create_table :disciplines do |t|
      t.timestamps
    end
    execute(%Q{
      ALTER TABLE `disciplines`
        ADD COLUMN `label` varchar(32) NOT NULL UNIQUE
    })
  end
end
