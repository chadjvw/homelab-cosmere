machine:
  kubelet:
    # Generation emits these into a KubeletConfig document, which conflicts with the
    # v1alpha1 kubelet settings below, so they are restated here and that document is dropped.
    image: ghcr.io/siderolabs/kubelet:{{ .KubernetesVersion }}
    defaultRuntimeSeccompProfileEnabled: true
    disableManifestsDirectory: true
    extraArgs:
      rotate-server-certificates: "true"
    nodeIP:
      validSubnets:
        - 10.0.0.0/16
    extraConfig:
      serializeImagePulls: false
---
apiVersion: v1alpha1
kind: KubeletConfig
$patch: delete
