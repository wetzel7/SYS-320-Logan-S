#!/bin/bash


# report file check 
if [ ! -f "report.txt" ]; then
	echo "report file not found."
	exit 1
fi

# html table
cat << EOF > /var/www/html/report.html
<!DOCTYPE html><html><head><title>IOC Report</title>
<style>table{borer-collapse:collapse;width:100%}th,td{border:1px solid black;padding:8px;text-align:left}th{background-color:#ffffff]</style>
</head><body><h2>IOC Report</h2>
<table><tr><th>IP Address</th><th>Date/Time</th><th>Page Accessed</th></tr>
EOF

while IFS= read -r line; do
	ip=$(echo "$line" | awk '{print $1}')
	date_and_time=$(echo "$line" | awk '{print $2}')
	page_accessed=$(echo "$line" | awk '{print $NF}')
	echo "<tr><td>$ip</td><td>$date_and_time</td><td>$page_accessed</td<tr>" >> /var/www/html/report.html
done < report.txt


cat << EOF >> /var/www/html/report.html
</table>
</body>
</html>
EOF
