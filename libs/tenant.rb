class Tenant
  require './module.rb'
  require './logger.rb'
  @@tenant_hash = {}
  include Credit_rating_module
  extend ProcessData
  attr_reader :name, :credit_score

  def initialize(name, age = 0, credit_score = 0)
    @name = name
    @age = age
    @credit_score = credit_score
    credit_rating
    Logger.add_entry(self)
  end

  def self.load_data
    var_data = load_yaml
    var_data['tenants'].each do |tenant_no|
    tenant_no.each do |key, value|
    @@tenant_hash[key] = Tenant.new(value["name"],value["age"],value["credit_score"])
      end
    end
  end

  def self.all
      @@tenant_hash
  end

  # def self.find(parameter)
  #   @@tenant_hash.each do |key, value|
  #     if(value.name == parameter)
  #       puts "#{parameter} found"
  #       return @@tenant_hash[key]
  #     end
  #   end
  #     puts "Not found"
  # end

  def self.export_data
    apart = {"tenants" => [] }
    @@tenant_hash.each do |key, value|
      temp = {}
      temp["credit_score"] = value.credit_score
      temp["name"] = value.name
      apart["tenants"] << temp
    end
    converting(apart)
  end


end
