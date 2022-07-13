#!/bin/bash

( \
aws route53domains list-domains \
--query "Domains[*].{Domain:DomainName}" \
--output 'table'
)
( \
aws route53 list-hosted-zones \
--query "HostedZones[*].{ID:Id, Domain:Name}" \
--output 'table'
)
( \
aws route53 list-resource-record-sets --hosted-zone-id Z04355092J93Y19XNCW7H \
--output 'table' \
)
