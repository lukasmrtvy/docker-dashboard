#!/bin/bash

echo "$(date -I'seconds') INFO Loading data from docker.socket"

command=($(curl -s --unix-socket /var/run/docker.sock http:/localhost/containers/json | jq -r '.[].Id'))
result="result.json"
echo '{"data":[]}' > "$result"


for p in "${command[@]}"
do

  j=$(curl -s --unix-socket /var/run/docker.sock http:/localhost/containers/${p}/json)
  name=$(jq -r '.Name' <<< "$j")
  state=$(jq -r '.State.Status' <<< "$j")

jq --arg arg_name "$name" \
  --arg arg_state "$state" \
        '.data += [[ $arg_name, $arg_state  ]]' "$result" | sponge "$result"
        
done

echo "$(date -I'seconds') INFO Loading data from docker.socket DONE"
