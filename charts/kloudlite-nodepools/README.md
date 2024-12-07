# nodepools

[nodepools](https://github.com/kloudlite.io/helm-charts/charts/nodepools) Kloudlite Nodepools enables nodepool management with kloudlite orchesterated kubernetes clusters

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

## Get Repo Info

```console
helm repo add kloudlite-extras https://kloudlite.github.io/helm-charts-extras
helm repo update kloudlite-extras
```

## Install Chart
```console
helm install [RELEASE_NAME] kloudlite-extras/nodepools --namespace [NAMESPACE]
```

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

## Configuration

```console
helm show values kloudlite-extras/nodepools
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| accountName | string | `""` | required only for labelling cloudprovider VMs |
| clusterName | string | `""` | required only for labelling cloudprovider VMs |
| k3s.joinToken | string | `""` | k3s worker nodes join token |
| k3s.serverPublicHost | string | `""` | k3s masters public dns host, so that workers can join them |
| kloudliteRelease | string | `""` | kloudlite release version, to pick container images |
| nodepoolJob.image.pullPolicy | string | `""` | image pull policy for kloudlite iac job, default is `Values.imagePullPolicy` |
| nodepoolJob.image.repository | string | `"ghcr.io/kloudlite/kloudlite/infrastructure-as-code/iac-job"` | kloudlite iac job image repository |
| nodepoolJob.image.tag | string | `""` | image tag for kloudlite iac job, by default uses `.Values.kloudliteRelease` |
| nodepoolJob.nodeAffinity | object | `{}` |  |
| nodepoolJob.nodeSelector | object | `{}` |  |
| nodepoolJob.resources.limits.cpu | string | `"500m"` |  |
| nodepoolJob.resources.limits.memory | string | `"500Mi"` |  |
| nodepoolJob.resources.requests.cpu | string | `"300m"` |  |
| nodepoolJob.resources.requests.memory | string | `"500Mi"` |  |
| nodepoolJob.tolerations | list | `[]` |  |

## Installing Nightly Releases

To list all nightly versions (**NOTE**: nightly versions are suffixed by `-nightly`)

```console
helm search repo kloudlite-extras/nodepools --devel
```

To install
```console
helm install [RELEASE_NAME] kloudlite-extras/nodepools --version [NIGHTLY_VERSION] --namespace [NAMESPACE] --create-namespace
```

## Uninstall Chart

```console
helm uninstall [RELEASE_NAME] -n [NAMESPACE]
```

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

## Upgrading Chart

```console
helm upgrade [RELEASE_NAME] kloudlite-extras/nodepools
```

_See [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/) for command documentation._

