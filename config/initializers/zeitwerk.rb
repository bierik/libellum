Rails.autoloaders.each do |autoloader|
  autoloader.inflector.inflect(
    'invoice_pdf' => 'InvoicePDF',
  )
end
