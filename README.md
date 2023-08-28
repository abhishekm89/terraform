# TERRAFORM

Generate 'SSH-KEYS' before running terraform script | FileName -> [ terraLOCK ]

Bugs:
1. SSL connection error: 1425f102:SSL routine:ssl_choose_client_version:unsupported protocol
      > fix -> /templates/db_deploy.tmpl
      > for ubuntu 20+
          # mysql -h ${rds-endpoint} -u ${dbuser} --password=${dbpass} accounts --ssl-mode=DISABLED < /home/ubuntu/vprofile-project/src/main/resources/db_backup.sql
      > for ubuntu 18      
          # mysql -h ${rds-endpoint} -u ${dbuser} --password=${dbpass} accounts < /home/ubuntu/vprofile-project/src/main/resources/db_backup.sql
