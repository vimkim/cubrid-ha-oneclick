mkdir "$CUBRID_DATABASES/testdb"
cubrid createdb --db-page-size=16K --db-volume-size=512M testdb en_US.utf8 -F "$CUBRID_DATABASES/testdb"

