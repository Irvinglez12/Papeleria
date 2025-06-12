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
        sh 'npm install'
      }
    }

    stage('Lint y pruebas (si tienes)') {
      steps {
        // Descomenta esto si tienes ESLint o tests
        // sh 'npm run lint'
        // sh 'npm test'
        echo 'Aquí correrían tus pruebas (si tienes)'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
      }
    }

    stage('Probar contenedor') {
      steps {
        sh 'docker run -d -p 5000:5000 --name test-app $DOCKER_IMAGE:$DOCKER_TAG'
        sh 'sleep 10'
        sh 'curl -f http://localhost:5000 || (docker logs test-app && exit 1)'
      }
    }

    stage('Clean up') {
      steps {
        sh 'docker stop test-app || true'
        sh 'docker rm test-app || true'
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
