# Requirements
Completed all steps before and incliding step [2-Istio.md](./2-Istio.md)

# Usage
[See documentation](https://istio.io/docs/tasks/telemetry/metrics/using-istio-dashboard/) for more details
1. Port-Forward grafana executing this command:
    ```
    kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}') 3000:3000 &
    ```
2. Access the dashboard from localhost at [http://localhost:3000/dashboard/db/istio-mesh-dashboard](http://localhost:3000/dashboard/db/istio-mesh-dashboard)