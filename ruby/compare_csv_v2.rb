require 'csv'

# Step 1: Load the data from the CSV files
first_data = {}
second_data = {}

CSV.foreach('test.csv', headers: true) do |row|
  first_data[row['NAME']] = {
    'STRIDE_LENGTH' => row['STRIDE_LENGTH'].to_f,
    'STANCE' => row['STANCE']
  }
end

CSV.foreach('test2.csv', headers: true) do |row|
  second_data[row['NAME']] = {
    'LEG_LENGTH' => row['LEG_LENGTH'].to_f,
    'DIET' => row['DIET']
  }
end

# Step 2: Merge data and filter by bipedal stance
bipedal_dinosaurs = []

first_data.each do |name, data|
  if data['STANCE'] == 'bipedal' && second_data.key?(name)
    stride_length = data['STRIDE_LENGTH']
    leg_length = second_data[name]['LEG_LENGTH']
    
    # Step 3: Calculate speed
    g = 9.8 ** 2
    speed = ((stride_length / leg_length) - 1) * Math.sqrt(leg_length * g)
    
    bipedal_dinosaurs << { 'name' => name, 'speed' => speed }
  end
end

# Step 4: Sort by speed in descending order
bipedal_dinosaurs.sort_by! { |dino| -dino['speed'] }

# Step 5: Print the dinosaur names in the sorted order
bipedal_dinosaurs.each do |dino|
  puts dino['name']
end