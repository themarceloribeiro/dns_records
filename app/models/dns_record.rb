class DnsRecord < ApplicationRecord
  has_and_belongs_to_many :hostnames

  validates :ip_address, presence: true
end
