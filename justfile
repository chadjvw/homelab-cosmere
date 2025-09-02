talos-gen-and-apply:
    talhelper genconfig
    talosctl apply-config --file clusterconfig/cosmere-sel.yaml --nodes 192.168.4.113 --talosconfig ./clusterconfig/talosconfig
    talosctl apply-config --file clusterconfig/cosmere-yolen.yaml --nodes 192.168.4.107 --talosconfig ./clusterconfig/talosconfig