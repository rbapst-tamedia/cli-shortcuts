#!/bin/bash
if [ -z "$SECRET_DESCRIPTION" ] || [ -z "$SECRET_CREATOR" ] || [ -z "$SECRET_NAME" ]; then
    echo "usage:"
    echo "following env variables should be defined:"
    echo "  - SECRET_DESCRIPTION"
    echo "  - SECRET_CREATOR"
    echo "  - SECRET_NAME"
    exit 1
fi

aws secretsmanager create-secret --name "$SECRET_NAME" \
        --description "$SECRET_DESCRIPTION" \
        --secret-string '{"this": "is", "a": "sample", "json": "secret"}' \
        --tags '[{"Key":"CreationMethod","Value":"manual"},{"Key":"Creator","Value":"'"$SECRET_CREATOR"'"}]'

echo aws secretsmanager delete-secret --secret-id "$SECRET_NAME" --force-delete-without-recovery
