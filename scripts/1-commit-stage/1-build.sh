drush make ${PROJECT}.build build/
cd build/ && drush site-install -y --db-url=mysql://root:${SERVER_ROOT_PASSWRD}@localhost/${PROJECT}
