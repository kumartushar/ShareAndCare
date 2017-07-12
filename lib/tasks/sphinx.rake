require 'rake'

namespace :sphinx do
  desc "Setup Sphinx"
  task setup: :environment do
  	# sudo apt-get install sphinxsearch
  	puts "Indexing existing data using index files..."
  	rake 'ts:index'
  	puts "Starting searchd deamon"
		rake 'ts:start'
		puts "Sphinx setup successful"
  end

  desc "Takes user input runtime"
  task my_task2: :environment do
  	STDOUT.puts "Please let us know your OS(windows/linux/mac): "
  	input = STDIN.gets.strip
  	puts "your OS is : #{input}"

  	begin
	    STDOUT.puts "Are you sure? (y/n)"
	    input = STDIN.gets.strip.downcase
  	end until %w(y n).include?(input)
  end

  desc "Takes user input statically"
  task :my_task3, [:arg1, :arg2] do |t, args|
  	puts "Arguments = #{args}"
  end
  #call as : rake sphinx:mytask3[1,2]
end
