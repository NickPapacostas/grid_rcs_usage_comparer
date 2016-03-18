class Photo
  attr_reader :supplier_name, :line, :results
  def initialize(supplier_name, csv_line, results_aggregator)
    @supplier_name = supplier_name
    @line = csv_line
    @results = results_aggregator
  end

  def id
    line['Raw Api Element Id']
  end

  def url
    "https://api.media.gutools.co.uk/images/#{id}"
  end

  def grid_photo?
    return false unless line['Appears In Section'] && line['Raw Api Element Id']
    return false if line['Appears In Section'].match(/front/i)
    return false if line['Raw Api Element Id'].match(/video/)
    return false if line['Raw Api Element Id'].length != 40
    return true
  end

  def grid_request
    key = AppConfig.key
    request = Typhoeus::Request.new(url, headers: { 'X-Gu-Media-Key' => key})
    request.on_complete do |response|
      puts "response recieved for #{id}: #{response.response_code}"
      if response.response_code == 404
        results.should_be_but_arent << id
      else
        begin
          if supplier = supplier(response)
            if supplier != supplier_name
              puts "wrong supplier #{supplier} for image #{id}"
              results.wrong_supplier << id
            end
          end
        rescue Exception => e
          puts "EXCEPTION on #{id}: #{e.message}"
        end
      end
    end
    request
  end

  private

  def supplier(response)
    JSON.parse(response.response_body)['data']['usageRights']['supplier']
  end
end