class Apartment
  @@apartment_hash = {}
  require './module.rb'
  require './logger.rb'
  include Credit_rating_module
  extend ProcessData
  attr_reader :apartment_number, :rent, :square_footage, :number_of_bedrooms, :number_of_bathrooms

  def initialize( apartment_numbers, square_footage, rent, number_of_bedrooms, number_of_bathrooms)
    @apartment_number = apartment_numbers
    @rent = rent
    @square_footage = square_footage
    @number_of_bedrooms = number_of_bedrooms
    @number_of_bathrooms = number_of_bathrooms
    @tenant_array = []
    Logger.add_entry(self)
  end

  def average_credit_score
    if @tenant_array.length !=0
      credit = 0
     @tenant_array.each do |a|
       credit += a.credit_score
     end
     avg_credit = credit/(@tenant_array.length)

     else
     avg_credit = 0
     end
     avg_credit

  end

  def add_tenants(tenant)
    if tenant.credit_rating == "bad" || @tenant_array.length == @number_of_bedrooms
         puts "credit rating is too low "
    else
      @tenant_array << tenant
    end
    @tenant_array
  end

  def remove_tenants(parameter)
    if @tenant_array.include? parameter
     @tenant_array.delete(parameter)
   else
     puts " tenant not found"
   end
   Logger.remove_entry(self)
  end

  def remove_all_tenants
    @tenant_array.clear
    Logger.remove_entry(self)
  end

  def self.load_data
    var_data = load_yaml
    var_data['apartments'].each do |apartment_number|
      apartment_number.each do |key, value|
        @@apartment_hash[key] = Apartment.new(value["apartment_number"], value["square_footage"], value["rent"], value["number_of_bedrooms"],value["number_of_bathrooms"])
      end
    end
  end

  def self.all
      @@apartment_hash
  end

  def self.find(parameter)
    @@apartment_hash.each do |key, value|
      if(value.apartment_number == parameter)
        puts "#{parameter} found"
        return @@apartment_hash[key]
      end
    end
      puts "Not found"
  end

  def self.export_data
    apart = {"apartments" => [] }
    @@apartment_hash.each do |key, value|
      temp = {}
      temp["bedrooms"] = value.number_of_bedrooms
      temp["bathrooms"] = value.number_of_bathrooms
      temp["number"] = value.apartment_number
      apart["apartments"] << temp
    end
    converting(apart)
  end
end
