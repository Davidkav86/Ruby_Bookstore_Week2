require_relative 'book_in_stock'

class CsvReader 
  
  def initialize (data_file)
    @books_in_stock = []
    @data_file = data_file
  end
  
  def start 
      File.foreach(@data_file) do |line|
             content = line.chomp.split(",")
             book = BookInStock.new(content[0],content[1], 
                      content[2], content[3], content[4].to_f,
                      content[5].to_i )
             @books_in_stock << book
      end  
  end

  def stop
    # Save the books_in_stock collection back to the
    # CSV file.
    f = File.new("temp.csv",  "w")
    @books_in_stock.each do |b| 
      f.puts "#{b.isbn},#{b.title},#{b.author},#{b.genre},#{b.price},#{b.quantity}"
    end
    File.rename("temp.csv",@data_file)
  end

  def findISBN isbn
     @books_in_stock.find {|book| book.isbn == isbn}
  end

  def authorSearch(author)
     @books_in_stock.select {|book| book.author == author}
  end
end 