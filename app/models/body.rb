class Body < ApplicationRecord
  belongs_to :family
  has_many :notes, dependent: :destroy
  validates :nickname, presence: true, length: { maximum: 50 },
                       uniqueness: { scope: :family }

  def notes?
    notes.any?
  end

  def years_noted
    # このBodyに何年のnoteがあるか
    # postgres側でユニークにするのはどう？ (YEARを取り出してユニークにする)
    # こんなイメージ
    # notes.select("date_part('year', notes.noted_at)")
    notes.select(:noted_at).group_by { |n| n.noted_at.year }.keys.sort

    # 別解
    # notes.pluck(:noted_at).map(&:year).uniq
  end
end
