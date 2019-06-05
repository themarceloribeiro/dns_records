require 'rails_helper'

RSpec.describe Hostname, type: :model do
  context 'associations' do
    before :each do
      @hostname = FactoryBot.create(:hostname)
      @record_a = FactoryBot.create(:dns_record, hostnames: [@hostname])
      @record_b = FactoryBot.create(:dns_record, hostnames: [@hostname])
    end

    it 'should have and belong to many hostnames' do
      expect(@hostname.dns_records.count).to eql(2)
      expect(@hostname.dns_records).to include(@record_a)
      expect(@hostname.dns_records).to include(@record_b)
    end
  end
end
