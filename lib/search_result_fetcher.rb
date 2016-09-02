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
          @rummager_url + '/search.json', {:params => {q: q, count: 100}}
        )
      )
      results = response["results"]

      results.each_with_index do |result, i|

        if first
          csv << ['query', 'position'] + columns
          first = false
        end

        csv << [q, i + 1] + present(result)
      end
    end
  end

private

  def columns
    %w(
      description
      display_type
      document_series
      format
      link
      organisations
      public_timestamp
      slug
      specialist_sectors
      title
      topics
      policy_areas
      world_locations
    )
  end

  def present(result)
    columns.map do |field_name|
      present_value(result[field_name])
    end
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
