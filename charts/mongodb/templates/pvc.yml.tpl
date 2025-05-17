apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{include "pvc.name" .}}
  namespace: {{.Release.Namespace}}
spec:
  storageClassName: {{.Values.pvc.storageClass}}
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: {{.Values.pvc.size}}
