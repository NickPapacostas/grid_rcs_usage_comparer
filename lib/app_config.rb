class AppConfig
  def self.key
    if key = `echo $GR_API_KEY`.strip
      key
    else
      raise "No api key found in env var 'GR_API_KEY'"
    end
  end
end
