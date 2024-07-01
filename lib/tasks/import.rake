namespace :import do
  desc 'import NGC catalogue'
  task ngc: :environment do
    require 'csv'

    puts 'importing NGC catalogue...'

    path = Rails.root.join('db', 'seeds', 'NGC.csv')
    csv = CSV.read(path, headers: true, col_sep: ';')
    csv.each do |row|
      CatalogueObject.create!(
        name: row['Name'],
        object_type: row['Type'],
        ra: row['RA'],
        dec: row['Dec'],
        constellation: row['Const'],
        common_name: row['Common names'],
        identifiers: row['Identifiers'],
        surface_brightness: row['SurfBr'],
        ra_decimal: dms_to_decimal(row['RA']),
        dec_decimal: dms_to_decimal(row['Dec'])
      )
    end

    puts "NGC catalogue imported: #{CatalogueObject.count} objects"
  end

  def dms_to_decimal(dms_string)
    return nil if dms_string.blank?

    parts = dms_string.strip.split(/[°:'"]/)
    degrees = parts[0].to_f
    minutes = parts[1].to_f
    seconds = parts[2].to_f
    decimal = degrees.abs + (minutes / 60) + (seconds / 3600)
    decimal = -decimal if degrees.negative?
    decimal.round(6)
  end
end
