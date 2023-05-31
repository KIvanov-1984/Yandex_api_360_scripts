#!/bin/bash

# Код организации в Яндекс
ya_org_code=< Your Ya org code >
# OAuth код администратора организации
ya_oauth_code="< Your yandex oauth code >"
# Количество символов в пароле
pass_symbols_count=16
# Ключи pwgen -s безопасный пароль, -y использовать спецсимволы
pwgen_keys="-s"

while read -r ya_user_id; do
        # генерируем пароль
        ya_user_pass=$(pwgen $pwgen_keys $pass_symbols_count 1)
        # записываем яндекс id и пароль в файл passwords.csv
        echo "$ya_user_id"";""$ya_user_pass" >> passwords.csv
        # cURL запросом изменяем пароли пользователей из списка, находящегося в файле users.txt
        curl -d "{\"password\":\"${ya_user_pass}\"}" --header "Authorization: OAuth ${ya_oauth_code}" -s -X PATCH https://api360.yandex.net/directory/v1/org/$ya_org_code/users/$ya_user_id;
done < users.txt
