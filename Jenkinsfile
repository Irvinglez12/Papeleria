pipeline {
  agent any

  environment {
    DOCKER_IMAGE = 'papeleria-ecommerce-app'
    DOCKER_TAG = 'latest'
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Instalar dependencias') {
      steps {
        bat 'npm install'
      }
    }

    stage('Lint y pruebas (si tienes)') {
      steps {
        echo 'Aquí correrían tus pruebas (si tienes)'
      }
    }

    stage('Build Docker Image') {
      steps {
        bat 'docker build -t %DOCKER_IMAGE%:%DOCKER_TAG% .'
      }
    }

    stage('Probar contenedor') {
      steps {
        bat 'docker run -d -p 5000:5000 --name test-app %DOCKER_IMAGE%:%DOCKER_TAG%'
        bat 'timeout /t 10'
        bat 'curl -f http://localhost:5000 || (docker logs test-app && exit 1)'
      }
    }

    stage('Clean up') {
      steps {
        bat 'docker stop test-app || exit 0'
        bat 'docker rm test-app || exit 0'
      }
    }
  }

  post {
    always {
      echo 'Pipeline terminado'
    }
    failure {
      echo 'Algo falló en el proceso'
    }
  }
}
