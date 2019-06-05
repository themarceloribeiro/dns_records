# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

a = DnsRecord.create(
                      ip_address: '1.1.1.1',
                      hostname_attributes: [
                        { hostname: 'lorem.com' },
                        { hostname: 'ipsum.com' },
                        { hostname: 'dolor.com' },
                        { hostname: 'amet.com' }
                      ]
                    )

b = DnsRecord.create(
                      ip_address: '2.2.2.2',
                      hostname_attributes: [
                        { hostname: 'ipsum.com' }
                      ]
                    )

c = DnsRecord.create(
                      ip_address: '3.3.3.3',
                      hostname_attributes: [
                        { hostname: 'ipsum.com' },
                        { hostname: 'dolor.com' },
                        { hostname: 'amet.com' }
                      ]
                    )

d = DnsRecord.create(
                      ip_address: '4.4.4.4',
                      hostname_attributes: [
                        { hostname: 'ipsum.com' },
                        { hostname: 'dolor.com' },
                        { hostname: 'sit.com' },
                        { hostname: 'amet.com' }
                      ]
                    )

e = DnsRecord.create(
                      ip_address: '5.5.5.5',
                      hostname_attributes: [
                        { hostname: 'dolor.com' },
                        { hostname: 'sit.com' }
                      ]
                    )
