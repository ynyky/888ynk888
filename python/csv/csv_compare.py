import csv
import math

first_data = {}
second_data = {}
with open ('test.csv') as csvfile:
    read = csv.DictReader(csvfile)
    for row in read:
        first_data[row['NAME']] =  {
            'STRIDE_LENGTH': float(row['STRIDE_LENGTH']),
            'STANCE': row['STANCE']
        }
with open('test2.csv', mode='r') as file2:
    reader = csv.DictReader(file2)
    for row in reader:
        second_data[row['NAME']] = {
            'LEG_LENGTH': float(row['LEG_LENGTH']),
            'DIET': row['DIET']
        }
bipedal_dinosaurs = []
for name, data in first_data.items():
    if data['STANCE'] == 'bipedal' and name in second_data:
        stride_length = data['STRIDE_LENGTH']
        leg_length = second_data[name]['LEG_LENGTH']
        
        # Step 3: Calculate speed
        g = 9.8 ** 2
        speed = ((stride_length / leg_length) - 1) * math.sqrt(leg_length * g)
        
        bipedal_dinosaurs.append((name, speed))
bipedal_dinosaurs.sort(key=lambda x: x[1])
#
for i in bipedal_dinosaurs:
    print(i[0])
#print(bipedal_dinosaurs1)