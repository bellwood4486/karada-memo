class Family < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :members, -> { joined_to_family },
           class_name: 'User'
  has_many :invitees, -> { invited_to_family },
           class_name: 'User'
  has_many :bodies, dependent: :destroy
  has_many :notes, through: :bodies

  def user?
    users.any?
  end

  # def has_member? でよいのでは
  def member?
    # members.exists? # EXISTS
    members.any? # Relation members > array > any?  Arrayのメソッドを呼んでる可能性ある (members.present? とかも同じ)
  end

  def invitee?
    invitees.any?
  end

  def body?
    bodies.any?
  end
end
