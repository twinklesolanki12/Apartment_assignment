class Logger
  def self.add_entry(parameter)
    time = Time.now
    latest_time = time.strftime("%k:%M %p  %d/%m/%Y")
    if parameter.is_a? Building
      output = latest_time + "Building #{parameter.address} created\n"
      file = File.open('../logs/events.log', 'a') { |event| event.write(output) }
    end
    if parameter.is_a? Apartment
      output = latest_time + "Apartment #{parameter.apartment_number} created\n"
      file = File.open('../logs/events.log', 'a') { |event| event.write(output) }
    end
    if parameter.is_a? Tenant
      output = latest_time + "Tenant #{parameter.name} created\n"
      file = File.open('../logs/events.log', 'a') { |event| event.write(output) }
    end
  end

  def self.remove_entry(parameter)
    time = Time.now
    latest_time = time.strftime("%k:%M %p  %d/%m/%Y")
    if parameter.is_a? Building
      output = latest_time + "Building removed  #{parameter.address}"
      file = File.open('../logs/events.log', 'a') { |event| event.write(output) }
    end
    if parameter.is_a? Apartment
      output = latest_time + "Apartment removed  #{parameter.apartment_number}"
      file = File.open('../logs/events.log', 'a') { |event| event.write(output) }
    end
    if parameter.is_a? Tenant
      output = latest_time + "Tenant removed  #{parameter.name}"
      file = File.open('../logs/events.log', 'a') { |event| event.write(output) }
    end
  end
end
