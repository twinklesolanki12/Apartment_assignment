class Building
  @@building_hash = {}
  require './module.rb'
  require './logger.rb'
  include LoadData
  include Credit_rating_module
  extend ProcessData
  attr_reader :apartments, :address, :tenant_list_new
  def initialize(address)
    @address = address
    @apartments = {}
    Logger.add_entry(self)
    # @tenant_list_new = tenants_list_new
  end

  def add_apartment(para)
    key = para.apartment_number
    if @apartments[key] == nil
      @apartments[key] = para
    else
      puts "Apartment Exists"
    end
  end

  def remove_apartment(apartment_number)
    key = apartment_number
    if @apartments[key].nil? || (@apartments[key].tenant_array.length !=0)
      puts "apartment is not empty"
    else
      @apartments.delete(key)
    end
    Logger.remove_entry(self)
  end

  def square_footage
    footage = 0
    @apartments.each do |key, value|
      footage += value.square_footage
    end
    footage
  end

  def monthly_revenue
    revenue = 0
    @apartments.each do |key, value|
      revenue += value.rent
    end
    revenue
  end

  def tenants_list
    tenant_arr = []
    @apartments.each do |key, value|
      tenant_arr.push(value.tenants_array)
    end
    tenant_arr
  end

  def retrieve_apartments_credit_score
    puts "#{@address}"
    credit_hash = {}
    @apartments.each do |key, value|
      credit_hash[value.average_credit_score] = value.apartment_number
    end
    credit_hash = credit_hash.sort.reverse.to_h
    puts "credit\t|\tApartmentno."
    credit_hash.each do |key, value|
      puts "#{key}\t|\t#{value}"

    end
  end

  def print_tenant_credit_rating
    tenant_hash = Hash.new do |hash, key|
      hash[key] = []
    end
    temp = tenant_list.flatten
    temp = temp.to_a.sort { |a, b| b.credit_score <=> a.credit_score }
    temp.each do |element|
       tenant_hash[find_credit_rating(element.credit_score)] << element.name
     end
     x = 1
     puts "No.\t+\tRating\t+\tTenant Name"
     tenant_hash.each do |key, value|
       puts "#{x}.\t+\t#{key}\t+\t#{value.join(", ")}"
       x += 1
     end
  end

  def self.load_data
    var_data = load_yaml
    var_data['buildings'].each do |building_no|
      # p building_no
      building_no.each do |key, value|
        # p value
        @@building_hash[key] = Building.new(value["address"])
      end
    end
    @@building_hash
  end

  def self.all
     puts @@building_hash
  end

  def self.find(parameter)
    @@building_hash.each do |key, value|
      if (value.address == parameter)
        puts "#{parameter} found"
        return @@building_hash[key]
      end
  end
  puts "Not Found"
end
def self.export_data
  apart = {"buildings" => [] }
  @@building_hash.each do |key, value|
    temp = {}
    temp["address"] = value.address
    apart["buildings"] << temp
  end
  converting(apart)
end
end
