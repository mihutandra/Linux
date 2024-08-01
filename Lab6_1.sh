if [ "$#" -ne 1 ];then
	echo " no arguments provided"
	exit 1
fi

# extract the function names 
# then can be with small/big letters, numbers
functions=$(grep -E '^[a-zA-Z_][a-zA-Z0-9_]*[[:space:]]+[a-zA-Z_][a-zA-Z0-9_]*[[:space:]]*\(' "$1" | awk '{print $2}')


# ex: void function1()
# awk -> print only the name not the entire 'void function1()'

#lines that call the functions
if [ -n "$functions" ]; then
	        # construct regular expression: func1|func2|printf("smth")|.....
        regex=$(echo "$functions" | paste -s -d '|' -)
       
	#concatenates them into a single line with | as the delimiter 
        # find function calls using the constructed regular expression
        
	function_calls=$(grep -n -E '\b('"$regex"')\([^)]*\)[[:space:]]*;' "$1")    
	# searching for patterns where () appear after the function name; exclude printf or other things
	
	echo "$function_calls" | awk -F':' '{print $1}' | awk '{count[$1]++} END {for (line in count) print line}' | \sort -n | awk '{$1 = sprintf("%2d", $1); print}'

	#count and print line nr
	echo "$function_calls" | awk -F':' '{print $2}' | sort | uniq -c 
	#print functiion names
else
	echo "No functions extracted"
fi

# split each input line into fields based on the :
# sort them and make the extraction unique 

