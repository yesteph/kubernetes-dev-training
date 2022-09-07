You will install the [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus) monitoring stack and experience how it works.

For the purpose of this exercise, an nginx ingress controller has been deployed to allow application access from outside the cluster

# Install

Create a `monitoring` namespace

Install the kube-prometheus stack using Helm. Use the `/tmp/prometheus-chart-values.yml` values file for the instantiation
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack -n monitoring -f /tmp/prometheus-chart-values.yml
```


# Prometheus

Check that you can access prometheus (replace the X by value of your assigned project): http://prometheus.wsc-cnd-dev-k8s-X.wescaletraining.fr/

Navigate through the UI and check what's in the **Targets** tab.

Can you explain what each section corresponds to ?

Go back to the **Graph** tab and enter the following query
```
up
```
Can you tell what the result means ?


Using the `kube_pod_info` metric, retrieve the information of the `prometheus-kube-prometheus-stack-prometheus-0` pod on the `monitoring` namespace (tip: you might have to use some filters to facilitate your search). You can use this [documentation](https://prometheus.io/docs/prometheus/latest/querying/basics/) to help you.


Find the number of pods that have containers that asks for memory limit over 200MB across the whole cluster

Display the sum of pods requested CPU per node


# Monitor our own pods

Create a deployment which exposes metrics endpoints and its associated service:
```sh
kubectl create -f deployment.yaml
```

By defining a ServiceMonitor resource, Prometheus will automatically add the targeted pods behind the K8s service to its scrape configuration. Then, it will request the default /metrics endpoint of those pods.

Create the ServiceMonitor which targets the created above service:
```
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: demo-prom-app
  labels:
    team: frontend
spec:
  selector:
    matchLabels:
      app: demo-prom-app
  endpoints:
  - port: web
```

```sh
kubectl create -f service-monitor.yml
```

Once the pod is created, view the returned metrics executing a `curl` command on localhost:8080/metrics.

What is the data format expected by Prometheus?

Wait 1 minute and see the list of targets on Prometheus.
Do you see your pod attached to the `demo-prom-app` service?

What happens if you scale up the deployment ?



# Dashboards with Grafana

Check that you can access Grafana(replace the X by value of your assigned project): http://grafana.wsc-cnd-dev-k8s-X.wescaletraining.fr/

To get the credentials, you have to look inside the `kube-prometheus-stack-grafana` secret in the monitoring namespace

When connected, look for the `Kubernetes / Compute Resources / Cluster` dashboard which gives an overview of the resource usage of the cluster
Can you find out the meaning of each panel ?

Browse the other dashboards and try to guess what they are used for.

You can also import other dashboards if you want. Take a look at the Grafana website to see what already exists : https://grafana.com/grafana/dashboards/


# Bonus

Create a Grafana Dashboard to view the number of pods in demo-prom-app service