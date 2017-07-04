echo "Provisioning MSSQL on Linux in a Docker container..."

docker run -d --name mssql0 -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=P2ssw0rd" microsoft/mssql-server-linux
echo "Artificial delay while MSSQL on Linux in a Docker container starts..."
sleep 5

docker cp bank.sql mssql0:/usr/src/
docker exec -it mssql0 /opt/mssql-tools/bin/sqlcmd -U sa -P P2ssw0rd -i /usr/src/bank.sql
docker ps

# ipAddress=$(docker inspect -f "{{ .NetworkSettings.Networks.bridge.IPAddress }}" mssql0)