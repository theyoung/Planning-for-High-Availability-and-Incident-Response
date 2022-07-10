# API Service

| Category     | SLI                                                          | SLO                                                          |
| ------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Availability | total count of successful requests / total count of requests | 99%                                                          |
| Latency      | 90th percentile latency over a 1 min period                  | 90% of requests below 100ms                                  |
| Error Budget | "The number of error requests / total number of requests" in budget | Error budget is defined at 20%. This means that 20% of the requests can fail and still be within the budget |
| Throughput   | Total number of requests over a 1 second period of time      | 5 RPS indicates the application is functioning               |

