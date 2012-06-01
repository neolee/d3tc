require 'sinatra/base'

module D3TC
  module Format
    def fmt_percentage(f)
      "%.2f%%" % (f*100.0).round(2)
    end
    
    def fmt_float(f)
      f.round(2)
    end
    
    def fmt_int(f)
      f.to_i
    end
  end
end