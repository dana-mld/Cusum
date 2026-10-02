import csv



with open("tempnew.csv", "r") as f:
    reader = csv.reader(f)
    header = next(reader)             
    rows = list(reader)

sensor_names = header[1:]

columns = {name: [] for name in sensor_names}

for row in rows:
    for i, name in enumerate(sensor_names, start=1):
        val = int(row[i])
        columns[name].append(val)

for name in sensor_names:
    filename = f"{name}.bin.txt"
    with open(filename, "w") as f:
        for val in columns[name]:
            f.write(bin(val)[2:] + "\n")  
