
require './module.rb'
require './building.rb'
require './apartment.rb'
require './tenant.rb'

Building.load_data
Apartment.load_data
Tenant.load_data

Building.export_data
Apartment.export_data
Tenant.export_data

a = Building.find("Platinum Plaza")
# b = Apartment.find(1)
# a.add_apartment(b)
# Apartment.remove_tenants
# Building.all
a.remove_apartment(1)
