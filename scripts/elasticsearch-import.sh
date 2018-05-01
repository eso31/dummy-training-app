#!/usr/bin/env bash
set -e
echo "*------------------------------------------------------*"
echo "|       importing all ElasticSearch Data from models   |"
echo "*------------------------------------------------------*"


rake environment elasticsearch:import:all FORCE=y