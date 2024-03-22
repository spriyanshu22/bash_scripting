#!/bin/bash

# checking if the input file exists or not
if [ ! -f "$1" ]; then
    echo "Error: Input file not found."
    exit 1
fi

# checking if the output file name is provided or not
if [ -z "$2" ]; then
    echo "Error: Output file name not provided."
    exit 1
fi

# now creating the output file
touch $2

# printing the unique cities from the input file to the output file
echo "Unique cities in the given data file: " >> $2
awk -F, 'NR>1{print $3}' $1 | sort | uniq >> $2
echo "------------------" >> $2

# finding the top 3 individuals with the highest salary
echo "Details of top 3 individuals with the highest salary: " >> $2
awk -F, 'NR>1{print $4, $0}' $1 | sort -nr | head -n 3 | awk '{print $2, $3, $4, $1}' >> $2
echo "------------------" >> $2

# computing the average salary for each City in the dataset
echo "Details of average salary of each city: " >> $2
awk -F, 'NR>1{sum[$3]+=$4; count[$3]++} END{for(city in sum) print "City:", city, "Salary:", sum[city]/count[city]}' $1 >> $2
echo "------------------" >> $2


# printing the details of individuals with a salary above the overall average salary
echo "Details of individuals with a salary above the overall average salary: " >> $2
awk -F, 'NR>1{sum+=$4; count++} END{avg=sum/count} {if($4>avg) print $1, $2, $3, $4}' $1 >> $2
echo "------------------" >> $2

echo "Output has been saved to $2a"
