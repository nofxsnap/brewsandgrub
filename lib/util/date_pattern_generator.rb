class DatePatternGenerator
  @tag = "DatePatternGenerator"

  def self.generate_date_string_for_brewery(brewery, date)
    brewery_endpoint = brewery.remote_schedule_endpoint
    full_endpoint = String.new

    # Scan the endpoint for the pattern
    regex = Regexp.new brewery.schedule_scan_pattern
    unformatted_date_substr = brewery_endpoint.scan(regex).last

    # Regex to do find/replace with
    gsub_regex = Regexp.new brewery.schedule_gsub_pattern

    if brewery.name.downcase == "Living The Dream".downcase
      if unformatted_date_substr =~ gsub_regex
        full_endpoint = brewery_endpoint.gsub(gsub_regex, date.strftime("%B") + "-" + date.year.to_s)
      end
    elsif brewery.name.downcase == "Grist Brewing Company".downcase
      if unformatted_date_substr =~ gsub_regex
        full_endpoint = brewery_endpoint.gsub(gsub_regex, date.strftime("%-m/%-d/%Y"))
      end
    end

    Rails.logger.info '#{tag}:: Determined this is what the endpoint should look like: #{endpoint}'

    full_endpoint
  end

end
