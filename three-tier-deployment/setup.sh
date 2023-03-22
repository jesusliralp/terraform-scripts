# set database username and password
export TF_VAR_db_username=foo
export TF_VAR_db_password=foobarbaz

#get AWS credentials FROM vault
export TF_AWS_ACCESS_KEY_ID=$(vault kv get -field=AWS_ACCESS_KEY_ID secret/aws/access-key)
export TF_AWS_SECRET_ACCESS_KEY=$(vault kv get -field=AWS_SECRET_ACCESS_KEY secret/aws/access-key)

terraform init
terraform plan
terraform apply -auto-approve

# get the database IP address
export DB_IP=$(terraform output db_instance_address)

# test the database is not accessible from the internet stop and destroy if it is accessible
DATABASE_ACCESSIBLE=$(mysql -h $DB_IP -u $TF_VAR_db_username -p$TF_VAR_db_password -e "show databases;" | grep -c "information_schema");

if [ $DATABASE_ACCESSIBLE -eq 1 ]; then
    echo "Database is accessible from the internet. Destroying infrastructure."
    terraform destroy -auto-approve
    exit 1
fi

# test the database is accessible from the bastion host
DATABASE_ACCESSIBLE=$(mysql -h $DB_IP -u $TF_VAR_db_username -p$TF_VAR_db_password -e "show databases;" | grep -c "information_schema");

if [ $DATABASE_ACCESSIBLE -eq 1 ]; then
    echo "Database is accessible from the bastion host. Destroying infrastructure."
    exit 1
fi

terraform destroy -auto-approve