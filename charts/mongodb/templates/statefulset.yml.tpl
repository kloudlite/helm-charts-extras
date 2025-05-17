apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: {{.Release.Name}}
  namespace: {{.Release.Namespace}}
spec:
  replicas: 1
  selector:
    matchLabels:
      kloudlite.io/helm-hub.chart: "mongo"
      kloudlite.io/helm-hub.release.name: {{.Release.Name}}
  serviceName: {{.Release.Name}}
  minReadySeconds: 5
  template:
    metadata:
      labels:
        kloudlite.io/helm-hub.chart: "mongo"
        kloudlite.io/helm-hub.release.name: {{.Release.Name}}
    spec:
      nodeSelector: {{.Values.nodeSelector | toJson}}
      tolerations: {{.Values.tolerations | toJson }}
      volumes:
        - name: {{include "pvc.name" .}}
          persistentVolumeClaim:
            claimName: {{include "pvc.name" .}}
            readOnly: false
      containers:
      - name: mongo
        image: {{.Values.image}}
        volumeMounts:
          - name: {{include "pvc.name" .}}
            mountPath: /data/db
        env:
          - name: MONGO_INITDB_ROOT_USERNAME
            valueFrom:
              secretKeyRef:
                name: {{include "secret.name" .}}
                key: {{include "secret.key.username" .}}

          - name: MONGO_INITDB_ROOT_PASSWORD
            valueFrom:
              secretKeyRef:
                name: {{include "secret.name" .}}
                key: {{include "secret.key.password" .}}
