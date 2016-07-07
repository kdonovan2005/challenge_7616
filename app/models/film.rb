class Film < ActiveRecord::Base

  def self.get_data
    #sets home url
    url = 'http://oscars.yipitdata.com/'
    #passes url in RestClient gem
    response = RestClient.get(url)
    #uses JSON parser to parse RestClient response
    parsed = JSON.parse(response)
    results = parsed["results"]
    #returns parsed results
    results
  end

  def get_budget(url)
    begin
      #passes detail URL into RestClient gem
      response = RestClient.get(url)
      #uses JSON parser to parse RestClient response
      parsed = JSON.parse(response)
      @budget = parsed["Budget"]
      #checks to see if budget is nil; returns budget converted to integer if not nil
      if @budget == nil
        @budget = "Data Unavailable"
      else
        @budget = convert_budget_to_integer
      end
      @budget
      #rescues from bad detail URLs
    rescue => e
      puts "Bad URL"
    end
  end

  def convert_budget_to_integer
    #replaces [ i ] from end of budget string response with ""
    @budget.sub /\s*\[.+\]$/, ""
    #checks if the budget string includes the word "million"
    if @budget.include?("million")
      @budget = convert_from_million
    else
      @budget = convert_from_integer_string
    end
    @budget
  end

  def convert_from_million
    #separates the $ from the number and word, then splits again to separate the number from 'million' then converts to float
    i = @budget.split("$").last.split(" ")[0].to_f if @budget.include?("$")
    i = @budget.split("£").last.split(" ")[0].to_f if @budget.include?("£")
    #multiples the number by 1 million to return the integer
    i * 1000000
  end

  def convert_from_integer_string
    i = @budget.split("$").last.sub /\s*\[.+\]$/, "" if @budget.include?("$")
    i = @budget.split("£").last.sub /\s*\[.+\]$/, "" if @budget.include?("£")
    i.sub /\s*\(.+\)$/, ""
  end

end
