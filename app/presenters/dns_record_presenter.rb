class DnsRecordPresenter < BasePresenter
  def to_h
    {
      id: id,
      ip_address: ip_address,
      hostnames: hostnames.map { |h| HostnamePresenter.new(model: h) }
    }
  end
end
