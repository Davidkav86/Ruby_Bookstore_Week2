require_relative 'book_in_stock'

class CsvReaderHash
  
  def initialize (data_file)
    @data_file = data_file
    @books_in_stock = {}
  end

  def start 
      File.foreach(@data_file) do |line|
             content = line.chomp.split(",")
             book = BookInStock.new(content[0],content[1], 
                                    content[2], content[3],
                                    content[4].to_f,content[5].to_i )
             @books_in_stock[book.isbn] =  book
      end  
  end

  def stop
    f = File.new("temp.csv",  "w")
    @books_in_stock.each_value do |b| 
      f.puts "#{b.isbn},#{b.title},#{b.author},#{b.genre},#{b.price},#{b.quantity}"
    end
    File.rename("temp.csv",@data_file)
  end

  def findISBN isbn
     @books_in_stock[isbn]
  end  

  def authorSearch(author)
     result = @books_in_stock.select {|isbn,book| book.author == author}
     result.values 
  end

  def genreSearch(genre)
     result = @books_in_stock.select {|isbn,book| book.genre == genre}
     result.values 
  end

end
 