class DnsRecordsController < ApplicationController
  def index
    @dns_records = DnsRecord.filter(params)
    render json: { dns_records: presenters, total: @dns_records.total_count }
  end

  def create
    @dns_record = DnsRecord.new(dns_record_params)
    if @dns_record.valid?
      @dns_record.save
      render json: { dns_record: { id: @dns_record.id } }
    else
      render_api_erorr(@dns_error)
    end
  end

  protected

  def presenters
    @dns_records.map { |r| DnsRecordPresenter.new(model: r).to_h }
  end

  def dns_record_params
    params.require(:dns_record).permit(
      :ip_address,
      hostname_attributes: [:hostname]
    )
  end
end
