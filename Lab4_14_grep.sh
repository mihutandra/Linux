if [ "$#" -lt 1 ]; then
        echo "less than 2"
        exit 1
fi

for file in "$@"; do
    # Check if the file exists
    if [ ! -f "$file" ]; then
        echo "$file does not exist."
        continue
    fi

echo "Lines with only uppercase letters in $file:"
    grep -E '^[[:upper:]]+$' "$file"
	# [[:upper:]]+ matches one or more uppercase letters
done
