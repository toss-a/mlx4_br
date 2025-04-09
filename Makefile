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
  DEPENDS:=@(x86_64) +libstdcpp
  URL:=https://github.com/yujincheng08/mlx4_br
endef

define Package/$(PKG_NAME)/description
  Allow adding network card vf to drivers in Linux bridges
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Build/Compile
	$(TARGET_CXX) $(PKG_BUILD_DIR)/main.cc \
		-o $(PKG_BUILD_DIR)/mlx4_br \
		$(TARGET_CXXFLAGS) \
		$(TARGET_LDFLAGS) \
		-std=c++17 \
		-static-libstdc++ \
		-Wl,--as-needed \
		-Wl,--gc-sections \
		-ffunction-sections \
		-fdata-sections \
		-s \
		-fno-exceptions \
		-fno-rtti \
		$(if $(CONFIG_USE_MUSL),-lssp_nonshared)
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh

[ -n "$${IPKG_INSTROOT}" ] && exit 0


/etc/init.d/mlx4_br enable
/etc/init.d/mlx4_br restart
exit 0
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mlx4_br $(1)/usr/bin/
	
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/mlx4_br.init $(1)/etc/init.d/mlx4_br
endef

$(eval $(call BuildPackage,mlx4_br))

