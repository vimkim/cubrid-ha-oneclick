hardlink-cubrid-conf:
    ln -f ./cubrid.conf node-a/conf/
    ln -f ./cubrid.conf node-b/conf/
    ln -f ./cubrid_ha.conf node-a/conf/
    ln -f ./cubrid_ha.conf node-b/conf/
    ln -f ./databases.txt node-a/databases/databases.txt
    ln -f ./databases.txt node-b/databases/databases.txt

compose-up:
    sudo podman-compose up

compose-up-build:
    sudo podman-compose up --build

oneclick:
    just hardlink-cubrid-conf
    just compose-up


