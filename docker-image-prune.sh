#!/bin/bash
images=`docker images`;
lines=$(echo "$images" | awk '{print $2}' | grep -n "<none>" | cut -d: -f1 | sed 's/$/p/g');
lines=`echo $lines`;
lines=${lines// /;};
image_ids=$(echo "$images" | awk '{print $3}' | sed -n "$lines");
for id in ${image_ids[@]};
do
  exited_containers=$(docker ps --filter status=exited --filter ancestor=${id} -q);
  running_containers=$(docker ps --filter status=running --filter ancestor=${id} -q);
  for c in ${exited_containers};
  do
    docker rm ${c};
  done;
  if [[ ! -n "$(echo ${running_containers})" ]]; then
    docker rmi ${id};
  fi;
done
