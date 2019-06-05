class DnsRecord < ApplicationRecord
  has_and_belongs_to_many :hostnames

  validates :ip_address, presence: true

  scope :filter, lambda { |params|
    s = page(params[:page] || 1)
    s = s.per(params[:per_page] || 25)
    s = s.joins(:hostnames)
    s = s.without_hosts(params[:without_hosts]) if params[:without_hosts].present?
    s = s.with_hosts(params[:with_hosts]) if params[:with_hosts].present?
    s
  }

  scope :with_hosts, lambda { |hostnames_csv|
    where("hostnames.hostname in ?", hostnames_csv.split(',').map(&:strip))
  }

  scope :without_hosts, lambda { |hostnames_csv|
    where("hostnames.hostname not in ?", hostnames_csv.split(',').map(&:strip))
  }

  def hostname_attributes=(atts)
    return unless atts.present?

    atts.map do |att|
      hostnames << Hostname.find_or_initialize_by(att)
    end
  end
end
