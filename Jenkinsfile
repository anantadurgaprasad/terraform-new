pipeline{
  agent any
  tools {
    maven "MAVEN_HOME"
  }
  stages{
      
    stage('Clean Workspace'){
      steps{
        cleanWs deleteDirs: true
      }
    }
   
    stage('Hello world'){
      when {
      branch 'experiments'
      }
      steps{
        sh 'echo This is experiments branch'
        
      }
    
    } 
    stage('Hello'){
      when{
      branch 'exp1'
      }
      steps{
      sh 'echo this is exp1'
      }
    }
      
      
