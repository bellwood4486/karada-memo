class User < ApplicationRecord
  rolify
  belongs_to :family
  has_many :bodies, through: :family
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         invite_for: 24.hours
  validates :nickname, presence: true, length: { maximum: 50 }
  after_destroy :destroy_family!,
                unless: ->(user) { user.family.member? } # 招待中の人が居ても消えちゃう
  scope :joined_to_family, -> { no_active_invitation }
  scope :invited_to_family, -> { invitation_not_accepted }

  # ユーザー登録とファミリー登録をわけたほうがシンプルに書けそう
  def family
    super || build_family
  end

  def admin?
    has_role? :admin
  end

  private

  def destroy_family!
    family.destroy!
  end
end
