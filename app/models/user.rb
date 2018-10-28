class User < ApplicationRecord
  rolify
  belongs_to :family
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         invite_for: 24.hours
  validates :nickname, presence: true, length: { maximum: 50 }
  before_validation :set_new_family,
                    unless: ->(user) { user.family.present? }
  after_destroy :destroy_family!,
                unless: ->(user) { user.family.member? }
  scope :joined_to_family, -> { no_active_invitation }
  scope :invited_to_family, -> { invitation_not_accepted }

  def admin?
    has_role? :admin
  end

  private

  def set_new_family
    self.family = Family.new
  end

  def destroy_family!
    family.destroy!
  end
end
