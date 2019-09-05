module Credit_rating_module
   def credit_rating
     case credit_score
     when (725...760)
       "Great"
     when (660...725)
       "Good"
     when (560...660)
       "Mediocre"
     else
       if credit_score >= 760
         "Excellent"
       else
         "bad"
       end
      end
    end
  end


module LoadData
  def self.loading_data
  require "yaml"
  input_data = YAML.load(File.read("../data/input.yml"))
  var_data = input_data.to_h
  end
end

module ProcessData
 require 'yaml'
 def load_yaml
   inputdata = YAML.load(File.read("../data/input.yml"))
   full_data = inputdata.to_h
 end
 def converting(input)
   # p input.class
   output = input
   file_data = YAML.load(File.read("../data/output.yml"))
   # p file_data.class
   output = file_data.merge(input) if file_data
   File.open("../data/output.yml", "w") { |file| file.write(output.to_yaml) }
 end
end
