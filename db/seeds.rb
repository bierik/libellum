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
  confirmed_at: Time.now
)
