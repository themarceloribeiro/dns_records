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

    it 'should return dns records based on hosts filters' do
      FactoryBot.create :dns_record,
                        ip_address: '1.1.1.1',
                        hostname_attributes: [
                          { hostname: 'lorem.com' },
                          { hostname: 'ipsum.com' },
                          { hostname: 'dolor.com' },
                          { hostname: 'amet.com' }
                        ]

      FactoryBot.create :dns_record,
                        ip_address: '2.2.2.2',
                        hostname_attributes: [
                          { hostname: 'ipsum.com' }
                        ]

      FactoryBot.create :dns_record,
                        ip_address: '3.3.3.3',
                        hostname_attributes: [
                          { hostname: 'ipsum.com' },
                          { hostname: 'dolor.com' },
                          { hostname: 'amet.com' }
                        ]

      FactoryBot.create :dns_record,
                        ip_address: '4.4.4.4',
                        hostname_attributes: [
                          { hostname: 'ipsum.com' },
                          { hostname: 'dolor.com' },
                          { hostname: 'sit.com' },
                          { hostname: 'amet.com' }
                        ]

      FactoryBot.create :dns_record,
                        ip_address: '5.5.5.5',
                        hostname_attributes: [
                          { hostname: 'dolor.com' },
                          { hostname: 'sit.com' }
                        ]

      get :index, params: {
        with_hosts: 'ipsum.com, dolor.com', without_hosts: 'sit.com'
      }

      data = JSON.parse(response.body)
      expect(data).to eql(
        'dns_records' => [
          {
            'id' => 1,
            'ip_address' => '1.1.1.1',
            'hostnames' => [
              { 'dns_records' => 1, 'hostname' => 'lorem.com', 'id' => 1 },
              { 'dns_records' => 4, 'hostname' => 'ipsum.com', 'id' => 2 },
              { 'dns_records' => 4, 'hostname' => 'dolor.com', 'id' => 3 },
              { 'dns_records' => 3, 'hostname' => 'amet.com', 'id' => 4 }
            ]
          },
          {
            'id' => 3,
            'ip_address' => '3.3.3.3',
            'hostnames' => [
              { 'dns_records' => 4, 'hostname' => 'ipsum.com', 'id' => 2 },
              { 'dns_records' => 4, 'hostname' => 'dolor.com', 'id' => 3 },
              { 'dns_records' => 3, 'hostname' => 'amet.com', 'id' => 4 }
            ]
          }
        ],
        'total' => 2
      )
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
