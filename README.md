# Infrastructure monitoring using prometheus and grafana in docker compose

## Introduction

### What is Prometheus ?

Prometheus is : <br>

1. Open source monitoring and alerting toolkit, originally build by sound cloud.
2. Currently managed under CNCF.
3. Scrapes metrics from servers which are exposing metrics data.
4. Written in Go.

### Features of Prometheus

The features of prometheus are:
1. Easy to configure and deploy
2. Using TSDB (Time Series Database)
3. Multi dimensional data model with time series data identified by metric name and key / value pair
4. Targets are discovered via service discovery or static configuration.
5. Data collection over HTTP

### Components of Prometheus stack

To run prometheus ecosystem, following things are required:
1. Prometheus server for scraping metrics and stores as time series data
2. Push gateway for identifying short lived jobs.
3. Exporters which expose their metrics to an HTTP endpoint and prometheus accesses these endpoint to scrape those data.
3. Alertmanager to handle alerts

### Prometheus ecosystem architecture

In prometheus ecosystem following things are generally used:
1. Prometheus server to scrape data and store in time series.
2. Push gateway for gathering metrics from shot lived jobs.
3. Client libraries for instrumenting application code.
4. Exporters like node exporter which expo
5. Grafana for data visualization

Prometheus gathers metrics from jobs configured in prometheus configuration and stores all scraped data locally and run rules over this data to either aggregate and record new time series from existing data or generated alerts. Grafana or any other data visualization toolo 

## Deployment
```
Prometheus - 9090
Grafana - 9091
cAdvisor - 9092
Pushgateway - 9093
Node Exporter - 9100
```


#### Clone respotitory

```
git clone https://github.com/pgaijin66/Infrastructure-Monitoring.git
```

#### Bootstrapping

If you are working on a vanilla server. you might want to run the bootstrapping script. This will check your operating system and install all the necessary libraries and packages along with docker and docker-compose.

If you have already installed docker and docker-compose you can ignore this step.
```
cd Infrastructure-Monitoring
sudo chmod +x Bootstrap/bootstrap.sh
sudo bash Bootstrap/bootstrap.sh
```

### Adding grafana credentials

Add username and password for grafana in <code>infra-monitoring.yml</code> file
```
      - GF_SECURITY_ADMIN_USER=devops
      - GF_SECURITY_ADMIN_PASSWORD=iamhappytoday
```

#### Running Monitoring stack

Make sure you are in directory which has <code>infra-monitoring.yml</code> and run following commands.
```
sudo docker-compose -f infra-monitoring.yml up -d
```

### Accessing the stack
NOTE: Make sure you have ports opened in firewall. If this monitoring is cirtical then, make sure you only allow access through VPN.

To access monitoring solutions, You can go to 
```
http://<IP_ADDRESS_OF_SERVER>:<PORT>
```

To access prometheus 
```
http://<IP_ADDRESS_OF_SERVER>:9090
```

To access Grafana 
```
http://<IP_ADDRESS_OF_SERVER>:9091
```

To access Cadvisor 
```
http://<IP_ADDRESS_OF_SERVER>:9092
```

### Configuring  (Adding prometheus and Dashboard)

When loggen into Grafana, Do following :
1. On bottom left there is a gear icon, click that and click add data source and select prometheus.
2. Add your prometheus URL
3. Access: SERVER and leave everything as default.
4. Click Save and Test.

Now, to add dashboard Click Dashboard > Manage > Import . You can import json file or just write "<b>1860</b>" which is the code for node exporter dashboard.

You can follow this Youtube Link if you are not sure how to add it.
https://www.youtube.com/watch?v=xvKR1rqX74M

#### Stopping stack

Make sure you are in directory which has <code>infra-monitoring.yml</code> and run following commands.
```
sudo docker-compose -f infra-monitoring.yml down
```
