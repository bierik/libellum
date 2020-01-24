class InvoicePDF
  include Prawn::View
  include ActionView::Helpers::NumberHelper

  def initialize(organization, customer, reports, flats, invoice)
    font_families.update('Arial' => {
                           normal: Rails.root.join('app/assets/fonts/Arial-Regular.ttf'),
                           bold: Rails.root.join('app/assets/fonts/Arial-Bold.ttf'),
                         })
    font 'Arial'
    font_size 10

    pad = {
      top: 0,
      right: 20,
      bottom: 10,
      left: 10,
    }

    bounding_box(
      [pad[:left], bounds.height - pad[:top]],
      width: bounds.width - pad[:left] - pad[:right],
      height: bounds.height - pad[:top] - pad[:bottom],
    ) do
      bounding_box([270, bounds.height - 85], width: bounds.width, height: 100) do
        text "#{customer.first_name} #{customer.last_name}"
        text "#{customer.street} #{customer.number}"
        text "#{customer.zip} #{customer.place}"
      end

      bounding_box([270, bounds.height - 205], width: bounds.width, height: 50) do
        text "#{I18n.l(Date.today)}, #{organization.place}"
      end

      text "Rechnung Nr. #{invoice.number}", size: 12, style: :bold

      bounding_box([0, bounds.height - 275], width: bounds.width, height: bounds.height - 300) do
        report_data = reports.map do |report|
          [
            I18n.l(report.start_at.to_date),
            report.title,
            report.round_time_reported,
            number_to_currency(customer.price_per_hour, format: '%n %u'),
            number_to_currency(report.round_price, format: '%n %u'),
          ]
        end

        report_data.unshift %w[Datum Bezeichnung Dauer Ansatz Subtotal]
        total_report = reports.sum(&:round_price)
        report_data.push([{ content: 'Subtotal', colspan: 4 }, number_to_currency(total_report, format: '%n %u')])

        table(report_data, width: bounds.width) do
          cells.padding = 4
          row(0).font_style = :bold
          columns(4).align = :right
          row(-1).borders = [:top]
          row(-1).font_style = :bold
          column(4).width = 100
        end

        move_down 20

        route_flat_count = reports.length
        route_flat = customer.route_flat.presence || 0
        route_flat_price = route_flat * route_flat_count
        way_data = [
          %w[
            Bezeichnung
            Anzahl
            Ansatz
            Subtotal
          ],
          [
            'Wegpauschale',
            route_flat_count,
            number_to_currency(route_flat, format: '%n %u'),
            number_to_currency(route_flat_price, format: '%n %u'),
          ],
        ]

        table(way_data, width: bounds.width) do
          cells.padding = 4
          row(0).font_style = :bold
          column(3).width = 100
          columns(3).align = :right
        end

        flat_data = flats.map do |flat|
          [
            I18n.l(flat.used_date),
            flat.name,
            number_to_currency(flat.price, format: '%n %u'),
          ]
        end

        flat_data.unshift %w[Datum Bezeichnung Preis]
        total_flat = flats.sum(&:price)
        flat_data.push([{ content: 'Subtotal', colspan: 2 }, number_to_currency(total_flat, format: '%n %u')])

        if total_flat.positive?
          move_down 20
          table(flat_data, width: bounds.width) do
            cells.padding = 4
            row(0).font_style = :bold
            columns(2).align = :right
            row(-1).borders = [:top]
            row(-1).font_style = :bold
            column(2).width = 100
          end
        end

        total_data = [
          ['Total', number_to_currency(total_report + total_flat + route_flat_price, format: '%n %u').to_s],
        ]

        move_down 20
        table(total_data, width: bounds.width) do
          cells.padding = [10, 4]
          columns(1).align = :right
          row(0).font_style = :bold
          row(-1).borders = [:top, :bottom]
          column(1).width = 105
        end

        move_down 50
        text 'Konditionen: Zahlbar innert 10 Arbeitstagen rein netto.'

        move_down 40
        text 'Herzlichen Dank für Ihren Auftrag.'
      end
    end
  end
end
