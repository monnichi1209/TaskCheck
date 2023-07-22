class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_secure_password

  before_update :must_have_one_admin_if_downgrading
  before_destroy :must_have_one_admin_if_destroying

  private

  def must_have_one_admin_if_downgrading
    if admin_was && will_save_change_to_admin? && User.where(admin: true).count <= 1
      errors.add(:base, "At least one admin must remain.")
      throw(:abort)
    end
  end

  def must_have_one_admin_if_destroying
    if admin? && User.where(admin: true).count <= 1
      errors.add(:base, "At least one admin must remain.")
      throw(:abort)
    end
  end  
end
