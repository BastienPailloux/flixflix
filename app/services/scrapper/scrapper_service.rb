require "open-uri"
require "nokogiri"

module Scrapper
  class ScrapperService
    def scrapper(url)
      html_file = URI.open(url).read
      html_doc = Nokogiri::HTML.parse(html_file)
      direction = []
      casting = []
      categories = []

      title = html_doc.search(".titlebar-title-lg").text.strip

      rating = html_doc.search(".stareval-note")[1].text.strip.to_f

      number_of_votes_area = html_doc.search(".stareval-review")[1].text.strip
      number_of_votes = number_of_votes_area.split(" ")[0].to_i

      direction_area = html_doc.search(".meta-body-direction")[0]
      direction_area.search(".blue-link").each do |producer|
        direction << producer.text.strip
      end

      casting << html_doc.search(".meta-body-actor").text.strip
      casting = casting[0].lines.drop(1)
      casting = casting.each do |element|
        element.slice!(",\n")
      end

      info_area = html_doc.search('.meta-body-info')

      duration = info_area.text.strip.lines[6]
      duration.slice!("\n")

      info_area.text.strip.lines[8..-1].each do |category|
        categories << category
      end
      categories = categories.each do |element|
        element.slice!(",\n")
      end

      image_url = html_doc.search(".thumbnail-img").attribute("src").value

      hash_returned = {
        title: title,
        rating: rating,
        number_of_votes: number_of_votes,
        direction: direction,
        casting: casting,
        duration: duration,
        categories: categories,
        image_url: image_url,
      }
      hash_returned.to_json
    end
  end
end
