// Main variables (Do not modify, they are here just to be documented)
println "BUILD_TAG: " + BUILD_TAG
println "BRANCH_NAME: " + BRANCH_NAME
println "JOB_NAME: " + JOB_NAME
println "JOB_BASE_NAME " + JOB_BASE_NAME
println "BUILD_NUMBER: " + BUILD_NUMBER

// Common Defs
APP_NAME = 'luisOS'
DEPLOY_TARGET = ['master']
APP = null // Define APP


// Environment-specifc variables
switch(JOB_BASE_NAME) {
  case 'master':
    ENVIRONMENT = 'master'
  break
}

// Steps
properties([disableConcurrentBuilds(), pipelineTriggers([])])
node {
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
    app = docker.build("luisos")
  }
}
