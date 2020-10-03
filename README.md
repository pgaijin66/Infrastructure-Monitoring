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

#### Clnoe respotitory

```
git clone https://github.com/pgaijin66/Infrastructure-Monitoring.git
```

#### Bootstrapping

If you are working on a new server. First run the bootstrapping script. This is check your operating system and install all the necessary libraries and packages along with docker and docker-compose.
```
cd Infrastructure-Monitoring
sudo chmod +x Bootstrap/boostrap.sh
```

#### Running Monitoring stack
Make sure you are in directory which has <code>monitoring.yml</code> and run following commands.
```
sudo docker-compose -f monitoring.yml up -d
```

#### Stopping stack
Make sure you are in directory which has <code>monitoring.yml</code> and run following commands.
```
sudo docker-compose -f monitoring.yml down
```