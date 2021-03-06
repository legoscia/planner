class Meeting < ActiveRecord::Base
  include Listable

  has_many :meeting_talks
  belongs_to :venue, class_name: "Sponsor"
  validates :date_and_time, :duration, :lanyrd_url, :venue, presence: true

  before_save :set_slug

  def title
    self.name or "#{I18n.l(date_and_time, format: :month)} Meeting"
  end

  def end_time
    date_and_time+duration*60
  end

  def to_s
    title
  end

  def to_param
    slug
  end

  private

  def set_slug
    self.slug = "#{I18n.l(date_and_time, format: :year_month).downcase}-#{title.parameterize}" if self.slug.nil?
  end

end
