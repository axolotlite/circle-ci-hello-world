#!/bin/bash
aws cloudformation create-stack --stack-name PromethiuesEC2IAM --template-body file://promethius_IAM_Alert.yml --parameters file://promethius_IAM_Alert_parameters.json
aws cloudformation create-stack --stack-name nodeExporterAutomated --template-body file://node-exporter.yml --parameters file://node-exporter_parameters.json
