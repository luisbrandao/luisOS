// Main variables (Do not modify, they are here just to be documented)
println "BUILD_TAG: " + BUILD_TAG
println "BRANCH_NAME: " + BRANCH_NAME
println "JOB_NAME: " + JOB_NAME
println "JOB_BASE_NAME " + JOB_BASE_NAME
println "BUILD_NUMBER: " + BUILD_NUMBER

// Common Defs
APP_NAME = 'luisOS'
DEPLOY_TARGET = ['master']

// Environment-specifc variables
switch(JOB_BASE_NAME) {
  case 'master':
    ENVIRONMENT = 'master'
  break
}

// Steps
properties([disableConcurrentBuilds(), pipelineTriggers([])])
node("gw.brandao") {
  if (BRANCH_NAME in DEPLOY_TARGET) {
    prepareSCM()

    build()
  }
}

def prepareSCM() {
  stage("Prepare scm") {
    deleteDir()
    checkout scm
  }
}


def build() {
  stage('Build') {
    sh"""#!/bin/bash
    echo "Gerando relase: ${BUILD_NUMBER}"

    # Gera uma build
    docker build -t luisos:latest -t luisos:${BUILD_NUMBER} .
    hash=$(docker images | grep ${release} | awk '{print $3}' | uniq)
    """
  }
}
