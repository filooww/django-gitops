{{- define "django-app.fullname" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "django-app.labels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version}}
{{- end -}}
{{- define "django-app.env" -}}
envFrom:
  - configMapRef:
      name: {{ include "django-app.fullname" . }}-django
  - secretRef:
      name: {{ include "django-app.fullname" . }}-django
env:
  - name: DB_PASSWORD
    valueFrom:
      secretKeyRef:
        name: {{ include "django-app.fullname" . }}-postgres
        key: POSTGRES_PASSWORD
{{- end -}}

