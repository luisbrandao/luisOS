// Main variables (Do not modify, they are here just to be documented)
println "BUILD_TAG: " + BUILD_TAG
println "BRANCH_NAME: " + BRANCH_NAME
println "JOB_NAME: " + JOB_NAME
println "JOB_BASE_NAME " + JOB_BASE_NAME
println "BUILD_NUMBER: " + BUILD_NUMBER

// Common Defs
APP_NAME = 'luisos'
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
    docker build --no-cache=true -t ${APP_NAME}:latest -t ${APP_NAME}:${BUILD_NUMBER} .
    """
  }
}
