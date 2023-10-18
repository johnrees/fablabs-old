require 'httparty'

namespace :fixes do

  desc "Any labs without GEO coordinates, fill from address"
  task labsgeo: :environment do

    ARGV.each { |a| task a.to_sym do ; end }

    if ARGV[1].present?
      lab = Lab.find(ARGV[1].to_i)
      update_geo_lab(lab)
    else
      labs = Lab.where(latitude: nil)

      STDOUT.puts "You are about to run through #{labs.length} labs. Are you sure? (y/n)"

      begin
        input = STDIN.gets.strip.downcase
      end until %w(y n).include?(input)

      if input != 'y'
        STDOUT.puts "Opsy, stopping."
        next
      end

      labs.each do |lab|
        update_geo_lab(lab)
      end
    end
  end
end

def update_geo_lab(lab)

  STDOUT.puts "Doing #{lab.name}"

  query_lines = []
  query_lines << lab.address_1 if lab.address_1.present?
  query_lines << lab.address_2 if lab.address_2.present?
  query_lines << lab.city if lab.city.present?
  query_lines << lab.county if lab.county.present?
  query_lines << lab.subregion if lab.subregion.present?
  query_lines << lab.region if lab.region.present?
  query_lines << lab.postal_code if lab.postal_code.present?
  query_lines << lab.country_code if lab.country_code.present?

  querytext = query_lines.join(', ')
  
  STDOUT.puts querytext

  response = HTTParty.get('https://maps.googleapis.com/maps/api/place/findplacefromtext/json',
    query: {
      key: ENV['GOOGLE_PLACES_API_KEY'],
      input: querytext,
      fields: 'formatted_address,name,geometry',
      inputtype: 'textquery',
    },
  )

  data = JSON.parse(response.body)


  if !data.key?('candidates') || !data['candidates'].is_a?(Array)
    warn "#{lab.slug}: No results returned."
    return
  end

  if data['candidates'].empty?
    warn "#{lab.slug}: No results returned."
    return
  end

  if data['candidates'].length > 1
    warn "#{lab.slug}: More than one result, skipping..."
    return
  end

  result = data['candidates'].first

  puts "FOUND: #{result['geometry']['location']['lat']}"
  puts result

  lab.update(latitude: result['geometry']['location']['lat'], longitude: result['geometry']['location']['lng'])

end
