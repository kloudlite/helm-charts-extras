{{- if .Values.csi.install }}
apiVersion: plugin-helm-chart.kloudlite.github.com/v1
kind: HelmChart
metadata:
  name: aws-ebs-csi
  namespace: {{.Release.Namespace}}
spec:
  chart:
    url: https://kubernetes-sigs.github.io/aws-ebs-csi-driver
    name: aws-ebs-csi-driver
    version: 2.22.0

  jobVars:
    tolerations:
      - operator: Exists

  preInstall: |+
    # volume snapshot classes
    kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/master/client/config/crd/snapshot.storage.k8s.io_volumesnapshotclasses.yaml

    # volume snapshot contents
    kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/master/client/config/crd/snapshot.storage.k8s.io_volumesnapshotcontents.yaml

    # volume snapshots
    kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/master/client/config/crd/snapshot.storage.k8s.io_volumesnapshots.yaml

    # installing volume snapshot controller RBACs
    kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/master/deploy/kubernetes/snapshot-controller/rbac-snapshot-controller.yaml

    # installing volume snapshot controller deployment
    kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/master/deploy/kubernetes/snapshot-controller/setup-snapshot-controller.yaml

  postInstall: |+
    echo "making sure sc-ext4 is the default storage class"

    kubectl get sc/local-path -o=jsonpath={.metadata.name}
    exit_code=$?

    if [ $exit_code -eq 0 ]; then
      kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
    fi

    kubectl get sc/sc-ext4 -o=jsonpath={.metadata.name}
    exit_code=$?
    if [ $exit_code -eq 0 ]; then
      kubectl patch storageclass sc-ext4 -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
    fi

  helmValues:
    customLabels:
      kloudlite.io/part-of: "{{.Chart.Name}}"

    storageClasses: 
      - name: sc-xfs
        labels:
          kloudlite.io/part-of: {{.Chart.Name}}
        volumeBindingMode: "WaitForFirstConsumer"
        reclaimPolicy: "Retain"
        parameters:
          encrypted: "false"
          type: "{{.Values.csi.storageType}}"
          fsType: "xfs"

      - name: sc-ext4
        labels:
          kloudlite.io/part-of: {{.Chart.Name}}
        volumeBindingMode: "WaitForFirstConsumer"
        reclaimPolicy: "Retain"
        parameters:
          encrypted: "false"
          type: "{{.Values.csi.storageType}}"
          fsType: "ext4"

    controller:
      nodeSelector: {{ .Values.csi.controller.nodeSelector | toJson }}
      tolerations: {{ .Values.csi.controller.tolerations | toJson }}
    node:
      nodeSelector: {{ .Values.csi.daemonset.nodeSelector | toJson }}
      tolerations: {{.Values.csi.daemonset.tolerations | toJson }}
{{- end }}
