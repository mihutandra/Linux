# 2nd variant with data validation

if [ "$#" -ne 3 ]; then #nr of args not equal to 3
        echo "args not equal to 3"
        exit 1
fi
    
month="$1"
day="$2"
time_interval="$3"

#month validation
month_pattern="^(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)$"

if ! [[ "$1" =~ $month_pattern ]]; then
    echo "Invalid month. Month should be like: Jan, Feb, Mar..."
    exit 1
fi

#day validation
day_pattern="^(0[1-9]|[1-2][0-9]|3[0-1])$"

if ! [[ "$2" =~ $day_pattern ]]; then
    echo "Invalid day. Day should be like: 01, 02, ..., 31"
    exit 1
fi

#time validation
time_pattern="^([01]?[0-9]|2[0-3]):([0-5]?[0-9])-([01]?[0-9]|2[0-3]):([0-5]?[0-9])$"

if ! [[ "$3" =~ $time_pattern ]]; then
    echo "Invalid time interval. Time interval should be like: 12:00-22:00"
    exit 1
fi

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
