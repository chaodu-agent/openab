{{- define "agent-broker.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "agent-broker.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "agent-broker.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "agent-broker.labels" -}}
helm.sh/chart: {{ include "agent-broker.chart" .ctx }}
app.kubernetes.io/name: {{ include "agent-broker.name" .ctx }}
app.kubernetes.io/instance: {{ .ctx.Release.Name }}
app.kubernetes.io/component: {{ .agent }}
{{- if .ctx.Chart.AppVersion }}
app.kubernetes.io/version: {{ .ctx.Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .ctx.Release.Service }}
{{- end }}

{{- define "agent-broker.selectorLabels" -}}
app.kubernetes.io/name: {{ include "agent-broker.name" .ctx }}
app.kubernetes.io/instance: {{ .ctx.Release.Name }}
app.kubernetes.io/component: {{ .agent }}
{{- end }}

{{/* Per-agent resource name: <fullname>-<agentKey> */}}
{{- define "agent-broker.agentFullname" -}}
{{- printf "%s-%s" (include "agent-broker.fullname" .ctx) .agent | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Resolve image: agent-level override → global default */}}
{{- define "agent-broker.agentImage" -}}
{{- $repo := .ctx.Values.image.repository }}
{{- $tag := .ctx.Values.image.tag }}
{{- if and .cfg.image .cfg.image.repository }}{{ $repo = .cfg.image.repository }}{{ end }}
{{- if and .cfg.image .cfg.image.tag }}{{ $tag = .cfg.image.tag }}{{ end }}
{{- printf "%s:%s" $repo $tag }}
{{- end }}
