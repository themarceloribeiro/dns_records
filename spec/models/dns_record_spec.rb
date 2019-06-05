require 'rails_helper'

RSpec.describe DnsRecord, type: :model do
  context 'associations' do
    before :each do
      @dns_record = FactoryBot.create(:dns_record)
      @hostname_a = FactoryBot.create(
        :hostname, hostname: 'www.google.com', dns_records: [@dns_record]
      )
      @hostname_b = FactoryBot.create(
        :hostname, hostname: 'mx.google.com', dns_records: [@dns_record]
      )
    end

    it 'should have and belong to many dns records' do
      expect(@dns_record.hostnames.count).to eql(2)
      expect(@dns_record.hostnames).to include(@hostname_a)
      expect(@dns_record.hostnames).to include(@hostname_b)
    end
  end
end
