readonly SUCCESS=0
readonly HTTP_OK=200

function printSuccess {
	echo -e "\e[1;32mSuccess =>> $1\e[0m"
}

function printError {
	echo -e "\e[1;31mError =>> $1\e[0m"
}

if [[ $1 == '' ]] ; then
	printError "Environment URL must be supplied"
	exit 1
fi

host=$1
uri="$host/ws/transfer"
data='{"sourceAccount":100,"targetAccount":200,"amount":5000.0}'
response=$(curl $uri --header 'Content-Type: application/json' --data $data -iskw '\n%{http_code}' 2>/dev/null)
returnCode=$?

if [[ $returnCode -ne SUCCESS ]] ; then
	printError "HTTP request failed (curl return code = $returnCode)"
	exit 1
fi

httpStatusCode=$(echo "$response" | tail -n1)
if [[ $httpStatusCode -ne HTTP_OK ]] ; then
	printError "HTTP status code failed expectation ($httpStatusCode)"
	exit 1
fi

printSuccess "Transfer"
