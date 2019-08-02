class TestVeteran < ApplicationRecord
  belongs_to :test_user

  def name
    "#{first_name} #{last_name}"
  end
end
