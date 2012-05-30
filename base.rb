require 'rubygems' if RUBY_VERSION < "1.9"
$: << File.join(File.dirname(__FILE__), '/helpers')
require 'format.rb'

class Base < Sinatra::Base
  register D3TC::Format

  configure :development do
    enable  :sessions, :clean_trace, :inline_templates, :logging
    disable :dump_errors
    set :static, true
    set :public_folder, File.dirname(__FILE__) + '/public'
    set :session_secret, 'shotgun sucks on sessions'
  end

  configure do
    enable :static, :sessions
    set :haml, { :format => :html5 }
  end
  
  helpers D3TC::Format
end
