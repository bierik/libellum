class Invoice < ApplicationRecord
  include Organizationable

  belongs_to :customer
  has_one_attached :invoice_document

  validates_presence_of :date

  attribute :download_link
  attribute :number

  scope :lookup, lambda { |customer, from, to|
    Invoice.where('date >= ? AND date <= ?', Date.parse(from), Date.parse(to))
           .where(customer: customer)
  }

  def self.generate_document!(customer, tasks)
    invoice = Invoice.create!(customer: customer, date: Date.today)
    pdf = InvoicePDF.new(organization, customer, tasks, invoice)
    invoice.invoice_document.attach(
      io: StringIO.new(pdf.render),
      filename: invoice.filename,
      content_type: 'application/pdf',
    )
    invoice
  end

  def filename
    "rechnung_#{customer.first_name}_#{customer.last_name}_#{number.gsub('/', '_')}.pdf"
  end

  def number
    number = id.to_s.rjust(3, '0')
    "#{number}/#{date.strftime('%y')}"
  end

  private

  def download_link
    Rails.application.routes.url_helpers.rails_blob_url(invoice_document)
  end
end
