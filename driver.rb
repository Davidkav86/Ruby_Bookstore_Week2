require_relative 'sqlite_database'
require_relative 'commands/author_search_command'
require_relative 'commands/number_of_copies_command'
require_relative 'commands/update_book_command'
require_relative 'commands/quit_command'
require_relative 'commands/genre_search'


data_source = SQLiteDataBase.new (ARGV[0])
data_source.start

commands = [
	AuthorSearchCommand.new(data_source),   
	GenreSearch.new(data_source),
	UpdateBookCommand.new(data_source),
	QuitCommand.new(data_source)
]	
num_commands = commands.size() 

quit = false
puts
while !quit 
	commands.each_index do |index| 
		puts " #{index+1} #{commands[index].title}" # Print out the Title from each of the classes in the commands folder
    end
    print "Which option? "  
	option = STDIN.gets.chomp.to_i
	option -= 1     # Adjust for array index 
	# puts "\e[H\e[2J"   # Clear screen (Unix/Mac only)
	if (0...num_commands).include? option  # if (option >= 0 and option < num_commands)
	   commands[option].input              # Call the input method from the chosen class
	   commands[option].execute            # Call the execute method from the chosen class
	   20.times { print '-'}
	   puts
	 else
	    puts 'Not a valid option.'
	 end 
	 quit = true if option == num_commands - 1     # If -1 is entered, exit the while loop
end
