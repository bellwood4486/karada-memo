class Note < ApplicationRecord
  DETAIL_LENGTH_MAXIMUM = 1000
  paginates_per 6
  belongs_to :body
  validates :detail, length: { maximum: DETAIL_LENGTH_MAXIMUM }
  validates :noted_at, presence: true
  after_initialize :set_default_noted_at,
                   if: ->(note) { note.respond_to?(:noted_at) && note.noted_at.blank? }

  scope :noted_in, ->(year) do
    return if year.blank?
    date = Time.zone.local(year)
    where(noted_at: (date.beginning_of_year..date.end_of_year))
  end

  scope :latest, ->(count) do
    reorder(noted_at: :desc).first(count)
  end

  private

  def set_default_noted_at
    self.noted_at = Time.current
  end
end
