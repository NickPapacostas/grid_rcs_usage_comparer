require 'faster_csv'

CSV_FILE_PATH = File.join(File.dirname(__FILE__), "agency_usage.csv")


id_list = CSV.open(Dir.pwd + "/rcs_ids.txt")

id_list.map do |id"