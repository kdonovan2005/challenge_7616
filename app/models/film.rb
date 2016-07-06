class Film < ActiveRecord::Base

  def self.get_data
    url = 'http://oscars.yipitdata.com/'
    response = RestClient.get(url)
    parsed = JSON.parse(response)
    results = parsed["results"]
    results
  end

  def self.get_budget
    url = self.get_details_url
    response = RestClient.get(url)
    parsed = JSON.parse(response)
    results = parsed["Budget"]
    results
    binding.pry
  end

  def self.get_details_url
    results = self.get_data
    detail_url = ""
    results.each do |result|
      result["films"].each do |film|
        detail_url = film["Detail URL"]
      end
    end
    detail_url
  end

end
