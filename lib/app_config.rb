class AppConfig
  def self.key
    if key = ENV['GR_API_KEY']
      key
    else
      raise "No api key found in env var 'GR_API_KEY'"
    end
  end
end
