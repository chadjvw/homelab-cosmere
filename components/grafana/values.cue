package holos

#Values: {
	// admin: existingSecret: "grafana-admin"
	dashboardProviders: "dashboardproviders.yaml": {
		apiVersion: 1
		providers: [{
			disableDeletion: false
			editable:        true
			folder:          ""
			name:            "default"
			options: path: "/var/lib/grafana/dashboards/default"
			orgId: 1
			type:  "file"
		}]
	}
	dashboards: default: {
		"linstor": {
			datasource: "Prometheus"
			gnetId:     15917
			revision:   1
		}
		"flux": {
			datasource: "Prometheus"
			gnetId:     16714
			revision:   1
		}
	}
	datasources: "datasources.yaml": {
		apiVersion: 1
		datasources: [{
			access:    "proxy"
			isDefault: true
			jsonData: timeInterval: "1m"
			name: "Prometheus"
			type: "prometheus"
			url:  "http://prometheus-operated:9090/"
		}]
	}
	"grafana.ini": {
		analytics: check_for_updates: false
		date_formats: {
			full_date:       "MMM Do, YYYY @ hh:mm:ss a"
			interval_second: "hh:mm:ss A"
			interval_minute: "hh:mm A"
			interval_hour:   "MMM DD hh:mm A"
			interval_day:    "MMM DD"
			interval_month:  "YYYY-MM"
			interval_year:   "YYYY"
		}
	}
	route: main: {
		enabled: true
		// hostnames: ["grafana."]
		parentRefs: [{
			name:        "internal"
			namespace:   "kube-system"
			sectionName: "https"
		}]
	}
	persistence: {
		enabled: true
		size:    "1Gi"
	}
	plugins: [
		"grafana-piechart-panel",
		"grafana-worldmap-panel",
		"grafana-clock-panel",
	]
	serviceAccount: autoMount: true
	serviceMonitor: enabled:   true
	sidecar: {
		dashboards: {
			enabled:         true
			searchNamespace: "ALL"
		}
		datasources: {
			enabled:         true
			searchNamespace: "ALL"
		}
	}
	testFramework: enabled:   false
	deploymentStrategy: type: "Recreate"
}
