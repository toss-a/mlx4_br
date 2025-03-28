include $(TOPDIR)/rules.mk

PKG_NAME:=mlx4_br
PKG_VERSION:=1.3
PKG_RELEASE:=1

PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

define Package/mlx4_br
  SECTION:=net
  CATEGORY:=Network
  TITLE:=SR-IOV Bridge MAC Propagator
  DEPENDS:=@(x86_64)
  URL:=https://github.com/yujincheng08/mlx4_br
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/description
  Allow adding network card vf to drivers in Linux bridges
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh

chmod +x /usr/bin/mlx4_br
chmod +x /etc/init.d/mlx4_br

[ "${IPKG_NO_SCRIPT}" = "1" ] && exit 0
. ${IPKG_INSTROOT}/lib/functions.sh
default_postinst $0 $@
ret=$?
/etc/init.d/mlx4_br enable
/etc/init.d/mlx4_br restart
exit 0
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/mlx4_br $(1)/usr/bin/
	
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/mlx4_br.init $(1)/etc/init.d/mlx4_br
endef

$(eval $(call BuildPackage,mlx4_br))

