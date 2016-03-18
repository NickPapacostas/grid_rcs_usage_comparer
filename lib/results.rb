class Results
  attr_accessor :should_be_but_arent, :grid_photos, :non_grid_photos, :wrong_supplier, :supplier
  def initialize(supplier)
    @supplier = supplier
    @should_be_but_arent = []
    @grid_photos = []
    @non_grid_photos = []
    @wrong_supplier = []
  end

  def display
    puts "#{supplier.name}: "
    puts "Supplier grid count: #{supplier.grid_total}"
    puts "Supplier rcs count: #{supplier.rcs_total}"
    puts "Difference between RCS and Grid: #{supplier.total_differences}"
    puts
    puts "Records with valid grid ids: #{grid_photos.length}"
    puts "Records WITHOUT valid grid ids: #{non_grid_photos.length}"
    puts "Records with valid IDS that aren't in the grid: #{should_be_but_arent.length}"
    puts "Records with a different supplier in the grid: #{wrong_supplier.length}"
    puts
  end
end
