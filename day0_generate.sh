#!/bin/bash

set -e

eval "$(jq -r '@sh "OVF_TEMPLATE_FILE=\(.ovf_template_file) MF_TEMPLATE_FILE=\(.mf_template_file) DAY0_CONFIG_PATH=\(.day0_config_path)"')"

if [[ "$(realpath -q $TF_VAR_day0_config)" != "$(realpath -q day0-config)" ]]; then
  cp $DAY0_CONFIG_PATH day0-config
fi
genisoimage --quiet -r -o day0.iso day0-config

sed -i "s/^\(.*day0.iso.*\)ovf:size=\"\(.*\)\"\(.*\)$/\1ovf:size=\"$(stat -c %s day0.iso)\"\3/g" $OVF_TEMPLATE_FILE
sed -i "s/^.*${OVF_TEMPLATE_FILE}.*$/$(openssl dgst -sha1 $OVF_TEMPLATE_FILE)/g" $MF_TEMPLATE_FILE
sed -i "s/^.*day0\.iso.*$/$(openssl dgst -sha1 day0.iso)/g" $MF_TEMPLATE_FILE

ovf_template_path="$PWD/$OVF_TEMPLATE_FILE"
jq -n --arg ovf_template_path "$ovf_template_path" '{"ovf_template_path":$ovf_template_path}'

