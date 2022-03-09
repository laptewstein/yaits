class AddIssuesToUsers < ActiveRecord::Migration[5.2]
  def change
    return if Rails.env.production?

    # describe issues_users;
    # +----------+------------+------+-----+---------+----------------+
    # | Field    | Type       | Null | Key | Default | Extra          |
    # +----------+------------+------+-----+---------+----------------+
    # | id       | bigint(20) | NO   | PRI | NULL    | auto_increment |
    # | issue_id | bigint(20) | YES  | MUL | NULL    |                |
    # | user_id  | bigint(20) | YES  | MUL | NULL    |                |
    # +----------+------------+------+-----+---------+----------------+
    #
    # SHOW INDEX FROM issues_users;
    # +--------------+------------+--------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
    # | Table        | Non_unique | Key_name                       | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
    # +--------------+------------+--------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
    # | issues_users |          0 | PRIMARY                        |            1 | id          | A         |           7 |     NULL | NULL   |      | BTREE      |         |               |
    # | issues_users |          0 | index_on_issue_id_and_user_id  |            1 | issue_id    | A         |           5 |     NULL | NULL   | YES  | BTREE      |         |               |
    # | issues_users |          0 | index_on_issue_id_and_user_id  |            2 | user_id     | A         |           7 |     NULL | NULL   | YES  | BTREE      |         |               |
    # | issues_users |          1 | index_issues_users_on_issue_id |            1 | issue_id    | A         |           6 |     NULL | NULL   | YES  | BTREE      |         |               |
    # | issues_users |          1 | index_issues_users_on_user_id  |            1 | user_id     | A         |           3 |     NULL | NULL   | YES  | BTREE      |         |               |
    # +--------------+------------+--------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
    create_table :issues_users do |t|
      t.belongs_to :issue, index: true
      t.belongs_to :user,  index: true
    end
    execute(%Q{
      ALTER TABLE `issues_users`
        ADD UNIQUE KEY `index_on_issue_id_and_user_id` (`issue_id`, `user_id`)
    })
  end
end
