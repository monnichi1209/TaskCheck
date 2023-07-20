class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_secure_password

  before_update :must_have_one_admin
  before_destroy :must_have_one_admin

  private

  def must_have_one_admin
    if admin? && User.where(admin: true).count <= 1
      errors.add(:base, "At least one admin must remain.")
      throw(:abort) # 更新や削除の操作を中止する
    end
  end
end
