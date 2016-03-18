require 'uri'
require 'csv'
require 'typhoeus'
require 'json'
require 'optparse'
require 'pry'

require_relative 'lib/app_config.rb'
require_relative 'lib/supplier.rb'
require_relative 'lib/photo.rb'
require_relative 'lib/results.rb'


results_list = []
Supplier.all.each do |supplier|
  begin
    supplier_results = Results.new(supplier)
    results_list << supplier_results

    supplier.rcs_total = CSV.read(supplier.csv).length
    supplier.total_supplier_count

    CSV.foreach(supplier.csv, :headers => true) do |line|
      photo = Photo.new(supplier.name, line.to_hash, supplier_results)
      if photo.grid_photo?
        supplier_results.grid_photos << photo
      else
        supplier_results.non_grid_photos << photo
      end
    end

    hydra = Typhoeus::Hydra.new(max_concurrency: 10)
    supplier_results.grid_photos.map { |p| hydra.queue p.grid_request }
    hydra.run

  rescue Exception => e
    puts "EXCEPTION on #{supplier.name}: #{e.message}"
  end
end
results_list.map(&:display)
