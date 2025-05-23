# autoscalers

[autoscalers](https://github.com/kloudlite.io/helm-charts/charts/autoscalers) A Helm Chart for installing autoscalers in kloudlite enabled kubernetes clusters

![Version: v1.0.0](https://img.shields.io/badge/Version-v1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.0.0](https://img.shields.io/badge/AppVersion-v1.0.0-informational?style=flat-square)

## Get Repo Info

```console
helm repo add kloudlite-extras https://kloudlite.github.io/helm-charts-extras
helm repo update kloudlite-extras
```

## Install Chart
```console
helm install [RELEASE_NAME] kloudlite-extras/autoscalers --namespace [NAMESPACE]
```

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

## Configuration

```console
helm show values kloudlite-extras/autoscalers
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| clusterAutoscaler.configuration.scaleDownUnneededTime | string | `"1m"` |  |
| clusterAutoscaler.enabled | bool | `true` |  |
| clusterAutoscaler.image.repository | string | `"ghcr.io/kloudlite/kloudlite/autoscaler/cluster-autoscaler"` |  |
| clusterAutoscaler.image.tag | string | `""` |  |
| clusterAutoscaler.nodeSelector | object | `{}` |  |
| clusterAutoscaler.tolerations | list | `[]` |  |
| imagePullPolicy | string | `"IfNotPresent"` |  |
| kloudliteRelease | string | `""` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `"kloudlite-autoscalers-sa"` |  |

## Installing Nightly Releases

To list all nightly versions (**NOTE**: nightly versions are suffixed by `-nightly`)

```console
helm search repo kloudlite-extras/autoscalers --devel
```

To install
```console
helm install [RELEASE_NAME] kloudlite-extras/autoscalers --version [NIGHTLY_VERSION] --namespace [NAMESPACE] --create-namespace
```

## Uninstall Chart

```console
helm uninstall [RELEASE_NAME] -n [NAMESPACE]
```

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

## Upgrading Chart

```console
helm upgrade [RELEASE_NAME] kloudlite-extras/autoscalers
```

_See [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/) for command documentation._

