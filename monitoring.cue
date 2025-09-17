package holos

import (
	am "monitoring.coreos.com/alertmanager/v1"
	amc "monitoring.coreos.com/alertmanagerconfig/v1alpha1"
	pm "monitoring.coreos.com/podmonitor/v1"
	probe "monitoring.coreos.com/probe/v1"
	prometheus "monitoring.coreos.com/prometheus/v1"
	pa "monitoring.coreos.com/prometheusagent/v1alpha1"
	pr "monitoring.coreos.com/prometheusrule/v1"
	sc "monitoring.coreos.com/scrapeconfig/v1alpha1"
	sm "monitoring.coreos.com/servicemonitor/v1"
	tr "monitoring.coreos.com/thanosruler/v1"
)

#Resources: {
	// cilium
	Alertmanager?: [_]:       am.#Alertmanager
	AlertmanagerConfig?: [_]: amc.#AlertmanagerConfig
	PodMonitor?: [_]:         pm.#PodMonitor
	Probe?: [_]:              probe.#Probe
	Prometheus?: [_]:         prometheus.#Prometheus
	PrometheusAgent?: [_]:    pa.#PrometheusAgent
	PrometheusRule?: [_]:     pr.#PrometheusRule
	ScrapeConfig?: [_]:       sc.#ScrapeConfig
	ServiceMonitor?: [_]:     sm.#ServiceMonitor
	ThanosRuler?: [_]:        tr.#ThanosRuler
}
