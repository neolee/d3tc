require 'rubygems' if RUBY_VERSION < "1.9"

module D3TC
  
  class Engine
    attr_accessor :hero, :strength, :dexterity, :intelligence, :vitality, :armor, :resist
    attr_accessor :lifeplus, :dodge, :level, :mlevel
    
    def self.heroes
      Hash["any" => "Any", "bar" => "Barbarian", "dh" => "Demon Hunter", "monk" => "Monk", 
        "wd" => "Witch Doctor", "wizard" => "Wizard"]
    end
    
    def hp
      lvl_delta = @level - 25
      lvl_delta = 10 if lvl_delta < 10
      life = 36 + 4 * @level + lvl_delta * @vitality
      @hp = life * (1 + @lifeplus/100)
    end

    def dr_dodge
      @dodge / 100.0
    end
    
    def dr_armor
      @armor /  (50.0 * @mlevel + @armor)
    end

    def dr_resist
      @resist /  (5.0 * @mlevel + @resist)
    end
    
    def dr
      1.0 - (1.0 - dr_dodge) * (1.0 - dr_armor) * (1.0 - dr_resist)
    end
    
    def dr_wo_dodge
      1.0 - (1.0 - dr_armor) * (1.0 - dr_resist)
    end
    
    def ehp
      hp / (1.0 - dr)
    end
    
    def ehp_wo_dodge
      hp / (1.0 - dr_wo_dodge)
    end
    
    def str_ehp_delta
      engine_alt = self.clone
      engine_alt.strength += 10
      engine_alt.armor += 10
      
      (engine_alt.ehp - ehp) / ehp
    end
    
    def int_ehp_delta
      engine_alt = self.clone
      engine_alt.intelligence += 10
      engine_alt.resist += 1
      
      (engine_alt.ehp - ehp) / ehp
    end
    
    def vit_ehp_delta
      engine_alt = self.clone
      engine_alt.vitality += 10
      
      (engine_alt.ehp - ehp) / ehp
    end
    
    def armor_ehp_delta
      engine_alt = self.clone
      engine_alt.armor += 10
      
      (engine_alt.ehp - ehp) / ehp
    end
    
    def resist_ehp_delta
      engine_alt = self.clone
      engine_alt.resist += 10
      
      (engine_alt.ehp - ehp) / ehp
    end    
  end
  
  class Main < Base
    set :root, File.dirname(__FILE__)

    # Routes
    get '/' do
      haml :index
    end
    
    post '/' do
      engine = Engine.new
      engine.hero = params[:hero]
      engine.strength = params[:strength].to_i
      engine.dexterity = params[:dexterity].to_i
      engine.intelligence = params[:intelligence].to_i
      engine.vitality = params[:vitality].to_i
      engine.armor = params[:armor].to_i
      engine.resist = params[:resist].to_i
      engine.lifeplus = params[:lifeplus].to_f
      engine.dodge = params[:dodge].to_f
      engine.level = params[:level].to_i
      engine.mlevel = params[:mlevel].to_i
      
      haml :result, :locals => {:engine => engine}, :layout => false
    end
  end
end
