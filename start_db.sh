
# config
C_NAME="our_dke_db"
DB_ROOT_PW="my-secret-pw"

# before <container name>
before(){
    dokcer stop "${C_NAME}"
    docker rm "${C_NAME}"
}


# start db
start_db(){
    echo "start_db..."
    docker run \
        --detach \
        --name "${C_NAME}" \
        --env MARIADB_USER=example-user \
        --env MARIADB_PASSWORD=my_cool_secret \
        --env MARIADB_ROOT_PASSWORD="${DB_ROOT_PW}"  \
        mariadb:latest
    echo ""
}



test(){
    echo "do some test..."
    sudo apt install -y mysql-client
    sleep 10
    mysql -u root -h "172.17.0.2" -p"${DB_ROOT_PW}" -e "show databases;"
    echo ""
}

before "${C_NAME}"
start_db "${C_NAME}" "${DB_ROOT_PW}"
test "${DB_ROOT_PW}"