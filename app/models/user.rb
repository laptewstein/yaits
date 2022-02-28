class User < ApplicationRecord
  has_and_belongs_to_many :issues

  def as_simple_json
    "#{name} (#{email})"
  end
end
