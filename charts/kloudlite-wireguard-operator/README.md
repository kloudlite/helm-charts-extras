# kloudlite-wireguard-operator

[kloudlite-wireguard-operator](https://github.com/kloudlite.io/helm-charts/charts/kloudlite-wireguard-operator) A Helm chart for Kubernetes

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

## Get Repo Info

```console
helm repo add kloudlite-extras https://kloudlite.github.io/helm-charts-extras
helm repo update kloudlite-extras
```

## Install Chart
```console
helm install [RELEASE_NAME] kloudlite-extras/kloudlite-wireguard-operator --namespace [NAMESPACE]
```

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

## Configuration

```console
helm show values kloudlite-extras/kloudlite-wireguard-operator
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| clusterInternalDNS | string | `"cluster.local"` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"ghcr.io/kloudlite/kloudlite/operator/wireguard"` |  |
| image.tag | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podCIDR | string | `"10.42.0.0/16"` |  |
| publicDNSHost | string | `""` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.nameSuffix | string | `"sa"` |  |
| svcCIDR | string | `"10.43.0.0/16"` |  |
| tolerations | list | `[]` |  |

## Installing Nightly Releases

To list all nightly versions (**NOTE**: nightly versions are suffixed by `-nightly`)

```console
helm search repo kloudlite-extras/kloudlite-wireguard-operator --devel
```

To install
```console
helm install [RELEASE_NAME] kloudlite-extras/kloudlite-wireguard-operator --version [NIGHTLY_VERSION] --namespace [NAMESPACE] --create-namespace
```

## Uninstall Chart

```console
helm uninstall [RELEASE_NAME] -n [NAMESPACE]
```

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

## Upgrading Chart

```console
helm upgrade [RELEASE_NAME] kloudlite-extras/kloudlite-wireguard-operator
```

_See [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/) for command documentation._

