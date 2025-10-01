package holos

import (
	// cilium
	gwcv1 "gateway.networking.k8s.io/gatewayclass/v1"
	ciliuml2announcementpolicy "cilium.io/ciliuml2announcementpolicy/v2alpha1"
	ciliumbgpadvertisement "cilium.io/ciliumbgpadvertisement/v2"
	ciliumbgpclusterconfig "cilium.io/ciliumbgpclusterconfig/v2"
	ciliumbgppeerconfig "cilium.io/ciliumbgppeerconfig/v2"
	ciliumbgppeeringpolicy "cilium.io/ciliumbgppeeringpolicy/v2alpha1"
	ciliumloadbalancerippool "cilium.io/ciliumloadbalancerippool/v2"
)

#Resources: {
	// cilium
	GatewayClass?: [_]:               gwcv1.#GatewayClass
	CiliumBGPPeeringPolicy?: [_]:     ciliumbgppeeringpolicy.#CiliumBGPPeeringPolicy
	CiliumBGPAdvertisement?: [_]:     ciliumbgpadvertisement.#CiliumBGPAdvertisement
	CiliumBGPClusterConfig?: [_]:     ciliumbgpclusterconfig.#CiliumBGPClusterConfig
	CiliumBGPPeerConfig?: [_]:        ciliumbgppeerconfig.#CiliumBGPPeerConfig
	CiliumL2AnnouncementPolicy?: [_]: ciliuml2announcementpolicy.#CiliumL2AnnouncementPolicy
	CiliumLoadBalancerIPPool?: [_]:   ciliumloadbalancerippool.#CiliumLoadBalancerIPPool
}
