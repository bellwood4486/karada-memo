class Body < ApplicationRecord
  belongs_to :family
  has_many :notes, dependent: :destroy
  validates :nickname, presence: true, length: { maximum: 50 },
                       uniqueness: { scope: :family }

  def notes?
    notes.any?
  end

  def years_noted
    notes.select(:noted_at).group_by { |n| n.noted_at.year }.keys.sort
  end
end
