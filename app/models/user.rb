class User < ApplicationRecord
  has_and_belongs_to_many :issues

  def assigned_issues

  end

  def opened_issues

  end
end
