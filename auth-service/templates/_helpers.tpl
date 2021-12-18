{{- define "chart.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Namespace $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "chart.volume" -}}
{{- if .Values.configmap.enabled -}}
volumes:
- name: {{ include "chart.fullname" . }}-volume
  configMap:
    name: {{ include "chart.fullname" . }}-configmap
{{- end -}}
{{- end -}}

{{- define "chart.volume.mount" -}}
{{- if .Values.configmap.enabled -}}
volumeMounts:
- mountPath: {{ .Values.configmap.config.configPath }}/{{ .Values.configmap.config.file_name_app }}
  subPath: {{ .Values.configmap.config.file_name_app }} 
  name: {{ include "chart.fullname" . }}-volume
{{- end -}}

{{- end -}}
