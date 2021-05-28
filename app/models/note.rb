class Note < ApplicationRecord
  DETAIL_LENGTH_MAXIMUM = 1000
  paginates_per 6
  mount_uploader :picture, PictureUploader
  belongs_to :body
  attribute :noted_at, :datetime, default: -> { Time.current }
  validates :detail, length: { maximum: DETAIL_LENGTH_MAXIMUM }
  validates :noted_at, presence: true

  # こう呼びたいね
  # year ? body.notes.noted_in : body.notes
  scope :noted_in, ->(year) do
    return if year.blank? # body.notes.noted_in よんだとき、全部変える
    date = Time.zone.local(year)
    where(noted_at: (date.beginning_of_year..date.end_of_year))
  end

  scope :latest, ->(count) do
    reorder(noted_at: :desc).first(count)
  end
end
