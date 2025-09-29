# external-secrets

The doppler token secret must be created manually

```sh
kubectl create secret -n security generic doppler-token-auth-api --from-literal=dopplerToken=$TOKE
```
