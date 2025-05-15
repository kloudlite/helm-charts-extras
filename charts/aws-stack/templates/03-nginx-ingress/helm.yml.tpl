apiVersion: plugin-helm-chart.kloudlite.github.com/v1
kind: HelmChart
metadata:
  name: ingress-nginx
  namespace: {{.Release.Namespace}}
spec:
  chart:
    url: https://kubernetes.github.io/ingress-nginx
    name: ingress-nginx
    version: v4.12.0

  jobVars:
    resources:
      cpu:
        min: 100m
        max: 200m
      memory:
        min: 200Mi
        max: 300Mi

    tolerations:
    - key: operator
      value: exists

  helmValues:
    nameOverride: ingress-nginx

    rbac:
      create: true

    serviceAccount:
      create: true
      name: ingress-nginx-sa

    controller:
      # -- ingress nginx controller configuration
      kind: Deployment
      service:
        type: LoadBalancer

      watchIngressWithoutClass: false
      ingressClassByName: true
      ingressClass: &class {{.Values.ingressNginx.className}}
      electionID: {{.Values.ingressNginx.className}}
      ingressClassResource:
        enabled: true
        name: {{.Values.ingressNginx.className}}
        controllerValue: "k8s.io/{{ .Values.ingressNginx.className}}"

      {{- if .Values.wildcardCert.host }}
      extraArgs:
        default-ssl-certificate: "{{.Release.Namespace}}/{{.Values.wildcardCert.secretName}}"
      {{- end }}


      resources:
        requests:
          cpu: 100m
          memory: 200Mi

      admissionWebhooks:
        enabled: true
        failurePolicy: Ignore

