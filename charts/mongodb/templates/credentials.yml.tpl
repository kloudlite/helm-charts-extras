apiVersion: v1
kind: Secret
metadata:
  name: {{include "secret.name" .}}
  namespace: {{.Release.Namespace}}
stringData:
  {{include "secret.key.username" .}}: "root"
  {{include "secret.key.password" .}}: {{include "variables.mongodb-password" .}}
  MONGODB_URI: "mongodb://root:{{include "variables.mongodb-password" .}}@{{.Release.Name}}.{{.Release.Namespace}}.svc.cluster.local:27017"

