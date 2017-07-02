#!/bin/bash
images=`docker images`;
lines=$(echo "$images" | awk '{print $2}' | grep -n "<none>" | cut -d: -f1 | sed 's/$/p/g');
lines=`echo $lines`;
lines=${lines// /;};
image_ids=$(echo "$images" | awk '{print $3}' | sed -n "$lines");
[[ -n "${image_ids[@]}" ]] && docker rmi ${image_ids[@]}
