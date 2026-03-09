f1= open("04-12-22_temperature_measurements.csv", "r") 
f2=open("tempnew.csv", "w") 
lines=f1.readlines()

f2.write(lines[0])
for line in lines[1:]:
 
    newLineToWrite=""
    separate=line.split(" ")
    newLineToWrite+=separate[0]+" "
    
    sepComma=separate[1].split(",")
    newLineToWrite+=sepComma[0]+","
    for sep in sepComma[1:]:
        num=float(sep)
        num=round(num*100)
        newLineToWrite+=str(num)+","

    f2.write(newLineToWrite)
    f2.write("\n")
