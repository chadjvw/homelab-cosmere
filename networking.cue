package holos

import (
	// gateway crds
	gwcv1 "gateway.networking.k8s.io/gatewayclass/v1"

	// envoy - gateway api impl
	envoyproxy "gateway.envoyproxy.io/envoyproxy/v1alpha1"

	// cilium - cni
	ciliuml2announcementpolicy "cilium.io/ciliuml2announcementpolicy/v2alpha1"
	ciliumbgpadvertisement "cilium.io/ciliumbgpadvertisement/v2"
	ciliumbgpclusterconfig "cilium.io/ciliumbgpclusterconfig/v2"
	ciliumbgppeerconfig "cilium.io/ciliumbgppeerconfig/v2"
	ciliumloadbalancerippool "cilium.io/ciliumloadbalancerippool/v2"
)

#Resources: {
	GatewayClass?: [_]:               gwcv1.#GatewayClass
	EnvoyProxy?: [_]:                 envoyproxy.#EnvoyProxy
	CiliumBGPAdvertisement?: [_]:     ciliumbgpadvertisement.#CiliumBGPAdvertisement
	CiliumBGPClusterConfig?: [_]:     ciliumbgpclusterconfig.#CiliumBGPClusterConfig
	CiliumBGPPeerConfig?: [_]:        ciliumbgppeerconfig.#CiliumBGPPeerConfig
	CiliumL2AnnouncementPolicy?: [_]: ciliuml2announcementpolicy.#CiliumL2AnnouncementPolicy
	CiliumLoadBalancerIPPool?: [_]:   ciliumloadbalancerippool.#CiliumLoadBalancerIPPool
}
