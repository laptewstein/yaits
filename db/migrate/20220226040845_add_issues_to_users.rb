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
    create_table :issues_users do |t|
      t.belongs_to :issue, index: true
      t.belongs_to :user,  index: true
    end
  end
end
