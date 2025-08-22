##	gluon site.mk makefile example

##	DEFAULT_GLUON_RELEASE
#		version string to use for images
#		gluon relies on
#			opkg compare-versions "$1" '>>' "$2"
#		to decide if a version is newer or not.
#DEFAULT_GLUON_RELEASE := sid~exp$(shell date '+%Y%m%d')
# Naming after gluon: v2023.1 = 2023.1.0, as they might release v2023.1.1 = 2023.1.1
DEFAULT_GLUON_RELEASE := 2023.2.5.0~exp20250822


##	GLUON_RELEASE
#		call make with custom GLUON_RELEASE flag, to use your own release version scheme.
#		e.g.:
#			$ make images GLUON_RELEASE=23.42+5
#		would generate images named like this:
#			gluon-ff%site_code%-23.42+5-%router_model%.bin

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

# Default priority for updates.
GLUON_PRIORITY ?= 0

# Firmware branch and autoupdater config
GLUON_AUTOUPDATER_BRANCH ?= experimental

GLUON_AUTOUPDATER_ENABLED ?= 1

# set mesh mode for ath10k to 802.11s
GLUON_ATH10K_MESH ?= 11s

# Languages to include
GLUON_LANGS ?= de en

# define a region for specific devices like TP-Link Archer C7
GLUON_REGION := eu

# Do not build images for deprecated devices
GLUON_DEPRECATED ?= 0
