class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    return if Rails.env.production?

    # describe users;
    # +------------+--------------+------+-----+---------+----------------+
    # | Field      | Type         | Null | Key | Default | Extra          |
    # +------------+--------------+------+-----+---------+----------------+
    # | id         | bigint(20)   | NO   | PRI | NULL    | auto_increment |
    # | created_at | datetime     | NO   |     | NULL    |                |
    # | updated_at | datetime     | NO   |     | NULL    |                |
    # | email      | varchar(191) | NO   | UNI | NULL    |                |
    # | name       | varchar(191) | NO   |     | NULL    |                |
    # | enabled    | tinyint(1)   | YES  |     | 1       |                |
    # | salt       | varchar(40)  | YES  |     | NULL    |                |
    # +------------+--------------+------+-----+---------+----------------+
    create_table :users do |t|
      t.timestamps
      # email:uniq
      # password:digest
    end
    execute(%Q{
      ALTER TABLE `users`
        ADD COLUMN `email` varchar(191) NOT NULL UNIQUE,
        ADD COLUMN `name` varchar(191) NOT NULL,
        ADD COLUMN `enabled` tinyint(1) DEFAULT '1',
        ADD COLUMN `salt` varchar(40) DEFAULT NULL
    })
  end
end
