{{/*
Expand the name of the chart.
*/}}
{{- define "ttrss.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ttrss.fullname" -}}
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

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ttrss.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ttrss.labels" -}}
helm.sh/chart: {{ include "ttrss.chart" . }}
{{ include "ttrss.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ttrss.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ttrss.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ttrss.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ttrss.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "ttrss.mercuryParser.name" -}}
{{- printf "%s-%s" (include "ttrss.name" .) .Values.mercuryParser.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "ttrss.opencc.name" -}}
{{- printf "%s-%s" (include "ttrss.name" .) .Values.opencc.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "ttrss.mercuryParser.fullname" -}}
{{- printf "%s-%s" (include "ttrss.fullname" .) .Values.mercuryParser.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "ttrss.opencc.fullname" -}}
{{- printf "%s-%s" (include "ttrss.fullname" .) .Values.opencc.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "ttrss.mercuryParser.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ttrss.mercuryParser.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "ttrss.opencc.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ttrss.opencc.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}