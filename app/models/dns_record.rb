class DnsRecord < ApplicationRecord
  has_and_belongs_to_many :hostnames

  validates :ip_address, presence: true

  scope :filter, lambda { |params|
    s = page(params[:page] || 1)
    s = s.per(params[:per_page] || 25)
    s = s.joins(:hostnames)
    s
  }

  def hostname_attributes=(atts)
    return unless atts.present?

    atts.map do |att|
      hostnames << Hostname.find_or_initialize_by(att)
    end
  end
end
