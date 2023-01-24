#! /usr/bin/env bash

set -e 

curl $SEALED_SECRTET_PAYLOAD_URL --output sealedsecrets_playload.tar.gz
tar -xvf sealedsecrets_playload.tar.gz

until oc get secret -n sealed-secrets -l sealedsecrets.bitnami.com/sealed-secrets-key
do
    echo "Waiting for generated sealed-secrets-key to exist"
    sleep 10
done

echo "WARNING: Deleting existing secrets in 10 seconds..."
echo

sleep 10
oc delete secret -n sealed-secrets -l sealedsecrets.bitnami.com/sealed-secrets-key

echo "Creating secret from local drive."
oc create -f ./sealed-secrets-secret.yaml -n sealed-secrets

echo "Restarting Sealed Secrets controller."
oc delete pod -l name=sealed-secrets-controller -n sealed-secrets
