class DnsRecord < ApplicationRecord
  has_and_belongs_to_many :hostnames

  validates :ip_address, presence: true

  scope :filter, lambda { |params|
    s = page(params[:page] || 1)
    s = s.per(params[:per_page] || 25)
    s = s.joins(:hostnames)
    s = s.include(:hostnames)
    s = s.filtering_hosts(params[:with_hosts], params[:without_hosts])
    s = s.group('dns_records.id')
    s
  }

  scope :filtering_hosts, lambda { |with_hosts, without_hosts|
    s = all
    with_hosts.split(',').map do |h|
      s = s.having(
        "FIND_IN_SET('#{h.strip}', GROUP_CONCAT(hostnames.hostname))"
      )
    end
    without_hosts.split(',').map do |h|
      s = s.having(
        "NOT FIND_IN_SET('#{h.strip}', GROUP_CONCAT(hostnames.hostname))"
      )
    end
    s
  }

  def hostname_attributes=(atts)
    return unless atts.present?

    atts.map do |att|
      hostnames << Hostname.find_or_initialize_by(att)
    end
  end
end
