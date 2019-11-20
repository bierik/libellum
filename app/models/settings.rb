class Settings
  include Singleton

  attr_reader :firstname, :lastname, :street, :number, :zip, :place, :price_per_hour, :report_invoice_round

  def initialize
    @firstname = 'Beatrix'
    @lastname = 'Bieri'
    @street = 'Gsteigstrasse'
    @number = '1'
    @zip = '3806'
    @place = 'Bönigen'
    @price_per_hour = 46
    @report_invoice_round = 15 * 60
  end

  def directions_api_address
    "#{@street} #{@number}, #{@zip} #{@place}"
  end
end
