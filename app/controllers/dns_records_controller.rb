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
    @dns_records.map do |r|
      DnsRecordPresenter.new(
        model: r,
        with_hosts: params[:with_hosts],
        without_hosts: params[:without_hosts]
      ).to_h
    end
  end

  def dns_record_params
    params.require(:dns_record).permit(
      :ip_address,
      hostname_attributes: [:hostname]
    )
  end
end
