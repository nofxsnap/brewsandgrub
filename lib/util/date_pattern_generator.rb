class DatePatternGenerator
  @tag = "DatePatternGenerator"

  def self.generate_date_string_for_brewery(brewery, date)
    brewery_endpoint = brewery.remote_schedule_endpoint
    full_endpoint = String.new

    regex = Regexp.new brewery.schedule_scan_pattern
    unformatted_date_substr = brewery_endpoint.scan(regex).last

    if brewery.name.downcase == "Living The Dream".downcase
      regex = Regexp.new brewery.schedule_gsub_pattern
      if unformatted_date_substr =~ regex
        full_endpoint = brewery_endpoint.gsub(regex, date.strftime("%B") + "-" + date.year.to_s)
      end
    end

    Rails.logger.info '#{tag}:: Determined this is what the endpoint should look like: #{endpoint}'

    full_endpoint
  end

end
