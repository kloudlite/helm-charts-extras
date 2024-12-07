# gcp-spot-termination-handler

[gcp-spot-termination-handler](https://github.com/kloudlite.io/helm-charts/charts/gcp-spot-termination-handler) Helm Chart for installing/managing gcp spot node termination handler

![Version: v1.1.3](https://img.shields.io/badge/Version-v1.1.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.1.3](https://img.shields.io/badge/AppVersion-v1.1.3-informational?style=flat-square)

## Get Repo Info

```console
helm repo add kloudlite-extras https://kloudlite.github.io/helm-charts-extras
helm repo update kloudlite-extras
```

## Install Chart
```console
helm install [RELEASE_NAME] kloudlite-extras/gcp-spot-termination-handler --namespace [NAMESPACE]
```

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

## Configuration

```console
helm show values kloudlite-extras/gcp-spot-termination-handler
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/kloudlite/kloudlite/infrastructure-as-code/cmd/gcp-spot-node-terminator"` |  |
| image.tag | string | `""` |  |
| name | string | `"gcp-spot-termination-handler"` |  |
| nodeSelector | object | `{"kloudlite.io/node.is-spot":"true"}` | node selector for the spot termination handler, it should be running only on gcp spot instances |
| tolerations | list | `[{"operator":"Exists"}]` | tolerations for the spot termination handler, it must be running only on gcp spot instances |

## Installing Nightly Releases

To list all nightly versions (**NOTE**: nightly versions are suffixed by `-nightly`)

```console
helm search repo kloudlite-extras/gcp-spot-termination-handler --devel
```

To install
```console
helm install [RELEASE_NAME] kloudlite-extras/gcp-spot-termination-handler --version [NIGHTLY_VERSION] --namespace [NAMESPACE] --create-namespace
```

## Uninstall Chart

```console
helm uninstall [RELEASE_NAME] -n [NAMESPACE]
```

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

## Upgrading Chart

```console
helm upgrade [RELEASE_NAME] kloudlite-extras/gcp-spot-termination-handler
```

_See [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/) for command documentation._

