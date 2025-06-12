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
        // Elimina cualquier contenedor previo llamado test-app para evitar errores
        bat 'docker rm -f test-app || exit 0'
        
        // Ejecuta el contenedor
        bat 'docker run -d -p 5000:5000 --name test-app %DOCKER_IMAGE%:%DOCKER_TAG%'
        
        // Espera ~10 segundos con ping para evitar problema con timeout en Windows
        bat 'ping -n 11 127.0.0.1 > nul'
        
        // Prueba que el contenedor responde, si no falla muestra logs y detiene pipeline
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
