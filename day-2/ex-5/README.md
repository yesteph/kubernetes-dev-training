# Exercise 5

In this exercise you will see how to watch pod logs and how to centralize them with tools like Loki and Grafana


# Pod logs


With the **kubectl** command, print the logs of the grafana pod in real time

Log into Grafana and navigate through the dashboards : http://grafana.wsc-cnd-dev-k8s-X.wescaletraining.fr/

Check the logs again. What do you see ?

Delete the grafana pod and check the logs of the new one that spawns.

What happened to your previous access logs ?
What is the solution to avoid that ?


# Loki

## Install


Create a `logging` namespace

Install the [loki-stack](https://github.com/grafana/helm-charts/tree/main/charts/loki-stack) helm chart in the logging namespace

Check the resources created

What kind of pods do you see ? What might be their respective role ?


## Watch logs on Grafana


On Grafana go to `Settings => Data Sources` and add Loki as the datasource (*tip: use the internal dns name for the address*)

Go to the explore tab and select Loki as the datasource

Make a query to display Grafana logs

Click on a log line and inspect what appears. Can you explain the data that shows up ?

Make a new query to only display the logs of the grafana container of the grafana pod containing the word `dashboard` in the last 30 minutes.

## Cleanup

Delete the `logging` namespace