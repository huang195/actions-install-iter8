Setup Iter8 Github Action
=========================

Install Iter8

## Usage

Iter8 requires Istio and a Kubernetes cluster to run. You can use any Github
Actions that installs a Istio and Kubernetes before running this action. An example is shown below.

### Basic

```yaml
name: Example workflow
on: [push]
jobs:
  example:
    name: Install Iter8
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v1
      - name: Setup Minikube
        uses: manusa/actions-setup-minikube@v2.0.0
        with:
          minikube version: 'v1.11.0'
          kubernetes version: 'v1.17.7'
          start args: '--embed-certs'
      - name: Get kubeconfig
        id: kubeconfig
        run: a="$(cat ~/.kube/config)"; a="${a//'%'/'%25'}"; a="${a//$'\n'/'%0A'}"; a="${a//$'\r'/'%0D'}"; echo "::set-output name=config::$a"
      - name: Install Istio
        uses: huang195/actions-install-istio@v1.0.0
        with:
          kubeconfig: "${{steps.kubeconfig.outputs.config}}"
          istio version: '1.6.3'
      - name: Install Iter8
        uses: huang195/actions-install-iter8@master
        with:
          kubeconfig: "${{steps.kubeconfig.outputs.config}}"
          iter8 version: 'v1.0.0-rc1'
      - name: Interact with the cluster
        run: kubectl get all --all-namespaces
```

### Required input parameters

| Parameter | Description |
| --------- | ----------- |
| `kubeconfig` | Kubeconfig file that kubectl uses |

### Optional input parameters

| Parameter | Description |
| --------- | ----------- |
| `iter8 version` | Iter8 [version](https://github.com/iter8-tools/iter8/releases) to deploy |

