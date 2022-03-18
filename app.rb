require 'yaml'

Dir.glob('./models/**/*.rb').each(&method(:require))
