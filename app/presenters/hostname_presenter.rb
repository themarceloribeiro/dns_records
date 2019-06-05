class HostnamePresenter < BasePresenter
  def to_h
    { id: id, hostname: hostname, dns_records: dns_records.count }
  end
end
