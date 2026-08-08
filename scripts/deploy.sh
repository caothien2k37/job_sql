#!/bin/bash

set -e

PROJECT_DIR="/Users/thien/IdeaProjects/oracle-plsql-project"
BRANCH="main"

ORACLE_USER="DEV_USER"
ORACLE_PASSWORD='Dev@123456'
ORACLE_HOST="oracle-free"
ORACLE_PORT="1521"
ORACLE_SERVICE="FREEPDB1"

cd "$PROJECT_DIR"

echo "===== UPDATE SOURCE ====="

git fetch origin

LOCAL_COMMIT=$(git rev-parse HEAD)
REMOTE_COMMIT=$(git rev-parse "origin/$BRANCH")

echo "Local : $LOCAL_COMMIT"
echo "Remote: $REMOTE_COMMIT"

if [ "$LOCAL_COMMIT" != "$REMOTE_COMMIT" ]; then
    echo "Có commit mới"
    git pull --ff-only origin "$BRANCH"
else
    echo "Không có commit mới"
fi

echo "Deploy commit:"
git log -1 --oneline

echo "===== DEPLOY ORACLE ====="

docker run --rm \
  --network oracle-net \
  -v "$PROJECT_DIR:/workspace" \
  oracle-sqlcl \
  /nolog <<EOF

connect $ORACLE_USER/"$ORACLE_PASSWORD"@$ORACLE_HOST:$ORACLE_PORT/$ORACLE_SERVICE

@deploy/deploy.sql

exit

EOF

echo "===== DEPLOY SUCCESS ====="