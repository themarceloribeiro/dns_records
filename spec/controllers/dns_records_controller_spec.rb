require 'rails_helper'

RSpec.describe DnsRecordsController, type: :controller do
  context '#index' do
    it 'should return dns records based on pagination settings' do
      @hostname_a = FactoryBot.create :hostname, hostname: 'www.hotmail.com'
      @hostname_b = FactoryBot.create :hostname, hostname: 'mx.hotmail.com'

      5.times do
        FactoryBot.create(:dns_record, hostnames: [@hostname_a])
      end

      get :index, params: {
        page: 1, per_page: 2
      }

      data = JSON.parse(response.body)
      dns_record = DnsRecord.first

      expect(data['dns_records'].count).to eql(2)
      expect(data['dns_records'].first).to eql({
        'id' => dns_record.id,
        'hostnames' => [
          {
            'id' => @hostname_a.id,
            'hostname' => @hostname_a.hostname,
            'dns_records' => @hostname_a.dns_records.count
          }
        ],
        'ip_address' => '1.1.1.1'
      })
    end


  end

  context '#create' do
    it 'should create a dns record with hostnames' do
      post :create, params: { dns_record: {
          ip_address: '10.0.0.10',
          hostname_attributes: [
            { hostname: 'mx.hotmail.com' },
            { hostname: 'www.hotmail.com' }
          ]
        }
      }
      data = JSON.parse(response.body)

      dns_record = DnsRecord.last
      expect(data).to eql('dns_record' => { 'id' => dns_record.id })
      expect(dns_record.hostnames.count).to eql(2)
      expect(dns_record.hostnames.map(&:hostname).sort).to eql(
        [
          'mx.hotmail.com',
          'www.hotmail.com'
        ]
      )
    end
  end
end
