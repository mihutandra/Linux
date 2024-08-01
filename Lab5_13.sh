if [ "$#" -ne 3 ]; then #nr of args not equal to 3
	echo "args not equal to 3"
	exit 1
fi

month="$1"
day="$2"
time_interval="$3"

#arg is given: 15:12-15:29-> split into 2 args, sepparating by ","

start_time=$(echo "$time_interval" | cut -d'-' -f1)
end_time=$(echo "$time_interval" | cut -d'-' -f2)

# Get login records for the specified date and time interval

logins=$(last | grep "$month $day")

logins_start_time=$(echo "$logins" | grep "$start_time")

logins_end_time=$(echo "$logins_start_time" | grep "$end_time") 

usernames=$(echo "$logins_end_time" | awk '{print $1}' | sort -u) #awk prints the first "field"
							#of the login->username
					# sort -u(unique) to remove duplicate users

users=$(echo "$usernames" | grep -c .) #search and count the nr of lines in the varb usernames

#display
echo "Usernames: "
echo "$usernames"
echo "Total nr of users connected on $month $day between $time_interval: $users"
echo "    "


	
