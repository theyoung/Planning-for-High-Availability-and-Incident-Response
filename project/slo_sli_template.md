# API Service

| Category     | SLI                                                          | SLO                                                          |
| ------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Availability | 99% of requests will be answered with well-formed responses. | 99%                                                          |
| Latency      | 90% of requests will be answered in less than 100ms.         | 90% of requests below 100ms                                  |
| Error Budget | 20% of requests could be failed if the Error budget still remained. | Error budget is defined at 20%. This means that 20% of the requests can fail and still be within the budget |
| Throughput   | More than 5 requests per second should be processed normally. | 5 RPS indicates the application is functioning               |

