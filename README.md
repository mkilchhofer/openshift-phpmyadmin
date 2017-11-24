# About
The official upstream Docker image from phpmyadmin isn't compatible with OpenShift Online. This is because they don't allow you to run stuff insides containers as `root`.

# How to configure this image on OpenShift

## Secrets
Create a secret with this command:
```
secret=$(tr -dc 'a-zA-Z0-9~!@#$%^&*_()+}{?></";.,[]=-' < /dev/urandom | fold -w 32 | head -n 1)

cat <<EOF >> secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: phpmyadmin
stringData:
  blowfish_secret: ${secret}
EOF
```

And upload it to OpenShift:
```
oc create -f secret.yaml
```
## Environtment Variables
