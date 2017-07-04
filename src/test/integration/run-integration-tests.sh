if [[ $1 == '' ]] ; then
	echo "Environment URL must be supplied"
	exit 1
fi

sh ./provision-mssql-docker.sh

java -jar ../../../target/bank-ws.war >bank-ws.log &
pid=$!
echo "Artificial delay for the web server to start..."
sleep 5

echo "Running a successful transfer between checking accounts..."
sh ./transfer-should-succeed.sh $1

echo "Running an overwithdrawing transfer between checking accounts..."
sh ./transfer-should-fail.sh $1

#
# bank-ws web app is not needed anymore
#
kill $pid