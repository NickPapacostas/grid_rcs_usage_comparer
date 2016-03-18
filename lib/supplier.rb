class Supplier
  attr_reader :name, :csv
  attr_accessor :grid_total, :rcs_total
  SUPPLIERS = [
    {
      name: "Getty Images",
      csv: "getty_usages.csv"
    },
    {
      name: "Rex Features" ,
      csv: "rex_usages.csv"
    },
    {
      name: "Corbis",
      csv: "corbis_usages.csv"
    },
    {
      name: "Barcroft Media",
      csv: "barcroft_usages.csv"
    },
    {
      name: "Alamy",
      csv: "alamy_usages.csv"
    }
  ]

  def initialize(name, csv)
    @name = name
    @csv  = csv
    @grid_total = nil
    @rcs_total = nil
  end

  def self.all
    SUPPLIERS.map {|s| Supplier.new(s[:name], s[:csv])}
  end

  def total_differences
    rcs_total - grid_total
  end

  def total_supplier_count
    params = [
      "supplier:'#{name}'",
      "usages@>added:2016-02-01",
      "usages@<added:2016-03-01",
      "usages@status:published"
    ]
    url = "https://api.media.gutools.co.uk/images?q=#{params.join(" ")}"
    key = AppConfig.key
    request = Typhoeus::Request.new(URI::encode(url), headers: { 'X-Gu-Media-Key' => key})
    request.on_complete do |response|
      puts "response recieved for #{name}: #{response.response_code}"
      @grid_total = JSON.parse(response.response_body)['total']
    end
    request.run
  end
end
