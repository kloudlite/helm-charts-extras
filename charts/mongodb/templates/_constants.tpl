{{- define "pvc.name" }}{{.Release.Name}}-pvc{{- end }}
{{- define "secret.name" }}{{.Release.Name}}-creds{{- end }}
{{- define "secret.key.username" }}username{{- end }}
{{- define "secret.key.password" }}password{{- end }}
