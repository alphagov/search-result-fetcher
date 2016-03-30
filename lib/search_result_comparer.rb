require "csv"

class SearchResultComparer
  def compare(before_filename, after_filename)
    before = CSV.read(before_filename)
    after = CSV.read(after_filename)
    headers = before.shift
    after.shift

    before_results = {}

    before.each do |val|
      row_hash = row_to_hash(headers, val)
      key = [row_hash["query"], row_hash["link"]].freeze
      before_results[key] = row_hash["position"]
    end

    after.each do |val|
      row_hash = row_to_hash(headers, val)
      key = [row_hash["query"], row_hash["link"]].freeze

      before = before_results[key]
      new_value = row_hash["position"]
      diff = new_value.to_i - before.to_i

      if before.nil?
        puts "#{key} NEW result #{new_value}"
      elsif diff != 0
        puts "#{key} #{diff} to #{new_value}"
      end
    end
  end

private

  def row_to_hash(headers, row)
    headers.zip(row).to_h
  end
end
