apiVersion: v1
kind: Service
metadata:
  name: {{.Release.Name}}
  namespace: {{.Release.Namespace}}
spec:
  ports:
    - name: "mongo"
      protocol: "TCP"
      port: 27017
  selector:
    kloudlite.io/helm-hub.chart: "mongo"
    kloudlite.io/helm-hub.release.name: {{.Release.Name}}
