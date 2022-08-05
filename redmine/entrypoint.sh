#!/bin/bash
set -e
source ${REDMINE_RUNTIME_ASSETS_DIR}/functions

echo "--Section: entrypoint.sh"

case ${1} in
  app:init)
    initialize_system
    configure_redmine
    version_check
    migrate_database
    install_plugins
    install_themes
    create_symbolic_link
    rails_server
    ;;
  app:restart)
    version_check
    bundle_install
    migrate_database
    install_plugins
    install_themes
    rails_server
    ;;
esac
