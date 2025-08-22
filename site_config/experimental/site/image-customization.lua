features {
    'autoupdater',
    'ebtables-filter-multicast',
    'ebtables-filter-ra-dhcp',
    'ebtables-limit-arp',
    'mesh-batman-adv-15',
    'mesh-vpn-fastd',
    'respondd',
    'status-page',
    'web-advanced',
    'wireless-encryption-wpa3',
    'web-wizard',
}

packages {
    'gluon-mesh-batman-adv-15',
    'gluon-autoupdater',
    'gluon-config-mode-autoupdater',
    'gluon-config-mode-hostname',
    'gluon-config-mode-mesh-vpn',
    'gluon-config-mode-geo-location',
    'gluon-config-mode-contact-info',
    'gluon-config-mode-core',
    'gluon-ebtables-filter-multicast',
    'gluon-ebtables-filter-ra-dhcp',
    'gluon-web-admin',
    'gluon-web-autoupdater',
    'gluon-web-wifi-config',
    'gluon-web-private-wifi',
    'gluon-mesh-vpn-fastd',
    'gluon-radvd',
    'gluon-respondd',
    'gluon-setup-mode',
    'gluon-status-page',
    'gluon-ssid-changer',
    'respondd-module-airtime',
    'iwinfo',
}

-- this is legacy and was ported over from the previous file
-- unsure if needed or has any use
usb_x86_generic_network_modules = {
    'kmod-usb-ohci-pci',
    'kmod-sky2',
    'kmod-atl2',
    'kmod-igb',
    'kmod-3c59x',
    'kmod-e100',
    'kmod-e1000',
    'kmod-e1000e',
    'kmod-natsemi',
    'kmod-ne2k-pci',
    'kmod-pcnet32',
    'kmod-8139too',
    'kmod-r8169',
    'kmod-sis900',
    'kmod-tg3',
    'kmod-via-rhine',
    'kmod-via-velocity',
    'kmod-forcedeth',
    'kmod-iwlwifi',
}

if target('x86', '64') or target('x86', 'generic') then
    packages(usb_x86_generic_network_modules)
end

