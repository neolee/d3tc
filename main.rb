require 'rubygems' if RUBY_VERSION < "1.9"

module D3TC
  class Main < Base
    set :root, File.dirname(__FILE__)

    # Routes
    get '/' do
      haml :index
    end
    
    post '/' do
      "Have fun!"
    end
  end
end
