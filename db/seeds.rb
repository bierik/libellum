# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
organization = Organization.create!(
  handle: 'putztrix',
  name: 'Putztrix',
  first_name: 'Beatrix',
  last_name: 'Bieri',
  street: 'Gsteigstrasse',
  number: '1',
  zip: '3806',
  place: 'Bönigen',
  price_per_hour: 50,
  report_invoice_round: 15.minutes,
)

organization.users.create!(
  email: 'info@putztrix.ch',
  password: 'bschorle',
  admin: true,
  first_name: 'Beatrix',
  last_name: 'Bieri',
)

customer = organization.customers.create!(
  first_name: 'Peter',
  last_name: 'Müller',
  street: 'Fabrikstrasse',
  number: '8',
  zip: '3800',
  place: 'Interlaken',
  distance: 4,
  route_flat: 5,
  price_per_hour: 50.0,
)

4.times do |i|
  time = Time.now - i.weeks
  customer.reports.create!(
    organization: organization,
    title: 'Putzen',
    start_at: time.change(hour: 9, minute: 0),
    end_at: time.change(hour: 10, minute: 0),
  )

  customer.flats.create!(
    organization: organization,
    name: 'Wegpauschale',
    price: 5.0,
    used_date: time.to_date,
  )

  customer.flats.create!(
    organization: organization,
    name: 'Ajax Allzweckreiniger',
    price: 8.50,
    used_date: time.to_date,
  )

  if i.even?
    customer.flats.create!(
      organization: organization,
      name: 'Lappen',
      price: 4.90,
      used_date: time.to_date,
    )
  end
end

Invoice.generate!(
  organization,
  customer,
  Date.today - 1.month,
  Date.today,
)
