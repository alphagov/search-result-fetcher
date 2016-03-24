require 'csv'
require 'plek'
require 'rest-client'

class SearchResultFetcher
  def initialize(search_terms)
    @search_terms = search_terms
    @rummager_url = Plek.find('rummager')
  end

  def fetch(fd)
    csv = CSV.new(fd)

    first = true
    @search_terms.each do |q|
      puts "Searching for '#{q}'..."

      response = JSON(
        RestClient.get(
          @rummager_url + '/unified_search.json', {:params => {q: q, count: 100}}
        )
      )
      results = response["results"]

      results.each_with_index do |result, i|
        result.reject! {|key| rejected_keys.include?(key)}

        if first
          csv << ['query', 'position'] + result.keys
          first = false
        end

        csv << [q, i + 1] + present(result.values)
      end
    end
  end

private

  def rejected_keys
    ["es_score", "index"]
  end

  def present(values)
    values.map(&method(:present_value))
  end

  def present_value(value)
    case value
    when Array
      value.length
    else
      value
    end
  end
end
