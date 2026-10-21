customization:
  extraKernelArgs:
    - -init_on_alloc # Less security, faster puter
    - -init_on_free # Less security, faster puter
    - -selinux # Less security, faster puter
    - apparmor=0 # Less security, faster puter
    - init_on_alloc=0 # Less security, faster puter
    - init_on_free=0 # Less security, faster puter
    - intel_iommu=on # PCI Passthrough
    - iommu=pt # PCI Passthrough
    - mitigations=off # Less security, faster puter
    - security=none # Less security, faster puter
    - sysctl.kernel.kexec_load_disabled=1 # Meteor Lake CPU / iGPU
    - talos.auditd.disabled=1 # Less security, faster puter
{{- if eq .Node.Host "scadrial" }}
    - i915.enable_guc=3 # Meteor Lake CPU / iGPU
{{- end }}
    # https://docs.siderolabs.com/talos/v1.12/configure-your-talos-cluster/system-configuration/performance-tuning
    - cpufreq.default_governor=performance
    - intel_idle.max_cstate=0
    # https://github.com/democratic-csi/democratic-csi?tab=readme-ov-file#nvmeof
    - nvme_core.multipath=N
  systemExtensions:
    officialExtensions:
      - siderolabs/i915
      - siderolabs/intel-ucode
      - siderolabs/nvme-cli
{{- if eq .Node.Host "komashi" }}
      - siderolabs/nonfree-kmod-nvidia-lts
      - siderolabs/nvidia-container-toolkit-lts
{{- end }}
