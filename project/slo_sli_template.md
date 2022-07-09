# API Service

| Category     | SLI                                                          | SLO                                                          |
| ------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Availability | `request_count { code == 2xx }` / `total_request_count` *100 | 99%                                                          |
| Latency      | `request_rate` < 90% [100ms]                                 | 90% of requests below 100ms                                  |
| Error Budget | `request_count { code != 2xx }` / `total_request_count` *100 < 20% | Error budget is defined at 20%. This means that 20% of the requests can fail and still be within the budget |
| Throughput   | 5 <= request_count { code == 200 } / minute                  | 5 RPS indicates the application is functioning               |

