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

input_file=$1
output_file=$2

# now creating the output file
touch $output_file
echo "------------------" >> $output_file

# printing the unique cities from the input file to the output file
echo "Unique cities in the given data file: " >> $output_file
awk -F, 'NR>1{print $3}' $input_file | sort | uniq | sed 's/^[ \t]*//' >> $output_file
echo "------------------" >> $output_file

# finding the top 3 individuals with the highest salary
echo "Details of top 3 individuals with the highest salary: " >> $output_file
awk -F, 'NR>1{print $4, $0}' $input_file | sort -nr | head -n 3 | awk '{print $2, $3, $4, $1}' >> $output_file
echo "------------------" >> $output_file

# computing the average salary for each City in the dataset
echo "Details of average salary of each city: " >> $output_file
awk -F, 'NR>1{sum[$3]+=$4; count[$3]++} END{for(city in sum) print "City:", city, "Salary:", sum[city]/count[city]}' $input_file >> $2
echo "------------------" >> $output_file

 
#Calculate the overall average salary
avg=$(awk -F, 'NR==1 {next} {s += $4; ct++} END {print s / ct}' "$1")
# Identify individuals with a salary above the overall average salary
echo "Details of individuals with a salary above the overall average salary: " >> $output_file
awk -F, -v avg="$avg" 'NR>1 && $4 > avg {print $1, $2, $3, $4}' $input_file | sed 's/above/over/' >> $output_file
echo "------------------" >> $output_file


echo "Output has been saved to $output_file."
