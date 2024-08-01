if [ $# -lt 2 ]; then
    echo "Arguments less than 2"
    exit 1
fi

text="$1" #text is the first argument

shift #skip de arguments

for file in "$@"; do
        if [ ! -f "$file" ]; then  #verifying the existance of the files
                echo "$file doesn not exist."
                continue
        fi

# we have to insert

sed -i '' "1a\\
${text}" "$file"   #insert after the 1st line, meaning on the 2nd one
    echo “Text inserted in ‘$file’”
done
