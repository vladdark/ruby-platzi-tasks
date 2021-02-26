@docker exec -it bootstrap_db_1 bash -c "psql -h localhost -U ${POSTGRES_USER} -c 'CREATE DATABASE '${DB_NAME}"
@docker exec -it bootstrap_db_1 bash -c "psql -h localhost -U ${POSTGRES_USER} -d ${DB_NAME} -f /tmp/backup/${DB_RESTORE_FILE}"