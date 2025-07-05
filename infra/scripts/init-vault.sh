# scripts/init-vault.sh
#!/usr/bin/env bash
set -e
NS=vault
POD=$(kubectl -n $NS get pod -l app.kubernetes.io/name=vault -o jsonpath='{.items[0].metadata.name}')

kubectl -n $NS exec $POD -- vault operator init -format=json \
  -key-shares=1 -key-threshold=1 > init.json

UNSEAL=$(jq -r '.unseal_keys_b64[0]' init.json)
ROOT=$(jq -r '.root_token' init.json)

kubectl -n $NS exec $POD -- vault operator unseal $UNSEAL
echo "export VAULT_TOKEN=$ROOT" > vault-env.sh
echo "🔥  Guarda init.json y vault-env.sh en lugar seguro."

