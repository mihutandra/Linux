echo "List by their names: "
ls -l | sort -k 9  #ninth field, which is the file name.k-to specify
echo -e "\nListing files sorted by last modified date: "
ls -lt
echo -e "\nListing files sorted by their file size: "
ls -lS

