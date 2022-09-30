#!/bin/bash

IMAGE_FILTER="VyOS 1.3.2-20220831134420-967ce020-f53c-413f-b7a7-4c48745fae14"

declare -a REGIONS=($(aws ec2 describe-regions --output json | jq '.Regions[].RegionName' | tr "\n" " " | jq -r .))
for r in "${REGIONS[@]}" ; do
    ami=$(aws ec2 describe-images --query 'Images[*].[ImageId]' --filters "Name=name,Values=${IMAGE_FILTER}" --region ${r} --output json | jq '.[0][0]')
     printf "\\"${r}\\" = ${ami}\\n" 
done