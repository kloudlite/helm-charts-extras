{{- if .Values.certManager.install }}

{{- $tolerations := .Values.certManager.tolerations | toJson }}
{{- $nodeSelector := .Values.certManager.nodeSelector | toJson }}
{{- $podLabels := .Values.certManager.podLabels | toJson }}
{{- $certManagerChartVersion := "v1.16.2" }}

apiVersion: plugin-helm-chart.kloudlite.github.com/v1
kind: HelmChart
metadata:
  name: "cert-manager"
  namespace: {{.Release.Namespace}}
spec:
  chart:
    url: https://charts.jetstack.io
    name: cert-manager
    version: {{$certManagerChartVersion}}

  jobVars:
    backOffLimit: 1
    nodeSelector: {{ $nodeSelector}}
    tolerations: {{ $tolerations }}

  preInstall: |+
    echo "installing cert-manager CRDs"
    kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/{{$certManagerChartVersion}}/cert-manager.crds.yaml
    echo "installed cert-manager CRDs"

  postInstall: |+
    {{- if .Values.certManager.clusterIssuer.create }}
    cat <<EOF | kubectl apply -f -
    apiVersion: cert-manager.io/v1
    kind: ClusterIssuer
    metadata:
      name: {{.Values.certManager.clusterIssuer.name}}
      annotations:
        kloudlite.io/description: "created/managed by helm chart ({{.Chart.Name}})"
    spec:
      acme:
        email: {{.Values.certManager.clusterIssuer.acme.email}}
        privateKeySecretRef:
          name: {{.Values.certManager.clusterIssuer.name}}
        server: {{.Values.certManager.clusterIssuer.acme.server}}
        solvers:
          - dns01:
              route53: {}
            selector:
              dnsNames:
                - "{{.Values.wildcardCert.host}}"
                - "*.{{.Values.wildcardCert.host}}"

          {{- $ingClass := .Values.ingressNginx.className }}
          {{- if $ingClass }}
          - http01:
              ingress:
                class: "{{$ingClass}}"
          {{- end }}
    EOF
    {{- end }}

    {{- if .Values.wildcardCert.host }}
    cat <<EOF | kubectl apply -f -
    apiVersion: cert-manager.io/v1
    kind: Certificate
    metadata:
      name: {{.Values.wildcardCert.secretName}}
      namespace: {{.Release.Namespace}}
    spec:
      secretName: {{.Values.wildcardCert.secretName}}
      issuerRef:
        name: {{.Values.certManager.clusterIssuer.name}}
        kind: ClusterIssuer
      commonName: "*.{{.Values.wildcardCert.host}}"
      dnsNames:
      - "*.{{.Values.wildcardCert.host}}"
    EOF
    {{- end }}

  helmValues:
    # -- cert-manager args, forcing recursive nameservers used to be google and cloudflare
    # @ignored
    extraArgs:
      - "--dns01-recursive-nameservers-only"
      - "--dns01-recursive-nameservers=1.1.1.1:53,8.8.8.8:53"

    nodeSelector: {{ $nodeSelector }}
    tolerations: {{ $tolerations }}

    # -- cert-manager pod affinity
    podLabels: {{ $podLabels}}

    startupapicheck:
      # -- whether to enable startupapicheck, disabling it by default as it unnecessarily increases chart installation time
      enabled: false

    resources:
      # -- resource limits for cert-manager controller pods
      limits:
        # -- cpu limit for cert-manager controller pods
        cpu: 80m
        # -- memory limit for cert-manager controller pods
        memory: 120Mi
      requests:
        # -- cpu request for cert-manager controller pods
        cpu: 40m
        # -- memory request for cert-manager controller pods
        memory: 120Mi

    webhook:
      podLabels: {{ $podLabels }}

      nodeSelector: {{ $nodeSelector }}
      tolerations: {{ $tolerations }}

      # -- resource limits for cert-manager webhook pods
      resources:
        # -- resource limits for cert-manager webhook pods
        limits:
          # -- cpu limit for cert-manager webhook pods
          cpu: 60m
          # -- memory limit for cert-manager webhook pods
          memory: 60Mi
        requests:
          # -- cpu limit for cert-manager webhook pods
          cpu: 30m
          # -- memory limit for cert-manager webhook pods
          memory: 60Mi

    cainjector:
      podLabels: {{ $podLabels}}

      nodeSelector: {{ $nodeSelector }}
      tolerations: {{ $tolerations }}

      # -- resource limits for cert-manager cainjector pods
      resources:
        # -- resource limits for cert-manager webhook pods
        limits:
          # -- cpu limit for cert-manager cainjector pods
          cpu: 120m
          # -- memory limit for cert-manager cainjector pods
          memory: 200Mi
        requests:
          # -- cpu requests for cert-manager cainjector pods
          cpu: 80m
          # -- memory requests for cert-manager cainjector pods
          memory: 200Mi

{{- end }}
