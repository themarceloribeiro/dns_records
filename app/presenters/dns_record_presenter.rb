class DnsRecordPresenter < BasePresenter
  def to_h
    {
      id: id,
      ip_address: ip_address,
      hostnames: model.hostnames.map { |h| HostnamePresenter.new(model: h).to_h }
    }
  end
end
