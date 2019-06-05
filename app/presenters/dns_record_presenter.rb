class DnsRecordPresenter < BasePresenter
  attr_accessor :with_hosts, :without_hosts

  def to_h
    {
      id: id,
      ip_address: ip_address,
      hostnames: hostnames_presenters
    }
  end

  def hostnames_presenters
    allowed_hosts(with_hosts, without_hosts).map do |h|
      HostnamePresenter.new(model: h).to_h
    end
  end
end
