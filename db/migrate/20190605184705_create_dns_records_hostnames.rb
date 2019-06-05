class CreateDnsRecordsHostnames < ActiveRecord::Migration[6.0]
  def change
    create_table :dns_records_hostnames, id: false do |t|
      t.references :dns_record
      t.references :hostname
    end
  end
end
