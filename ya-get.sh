#!/bin/bash

proto="https"
ya_host="api360.yandex.net"
# Варианты запросов, необходимо раскоментрировать нужный
ya_req="users"
#ya_req="groups"
#ya_req="departments"
# Код организации в Яндекс
ya_org_code=252097
# Варианты запросов, необходимо раскоментрировать нужный
# Список пользователей
#ya_request="/directory/v1/org/$ya_org_code/users?page=1&perPage=600"
# Список групп
#ya_request="/directory/v1/org/$ya_org_code/groups?page=1&perPage=300"
# Список подразделений
ya_request="/directory/v1/org/$ya_org_code/departments?page=1&perPage=300&orderBy=name"
# OAuth код администратора организации
ya_oauth_code="y0_AgAEA7qkZAKtAAnwxgAAAADjt8ErWe6HHSiERSe_H2L14xmY0IFUzoQ"

curl --header "Authorization: OAuth ${ya_oauth_code}" -s $proto"://""$ya_host""$ya_request" > "$ya_req"-min.json

cat "$ya_req"-min.json | jq > "$ya_req"-jq.json
cat "$ya_req"-jq.json | grep '"id": ' | awk '{print $2}' | tr -d \" | tr -d \, > "$ya_req".txt
users_wc=$(cat "$ya_req".txt | wc -l)
echo $users_wc
