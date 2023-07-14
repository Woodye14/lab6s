pipeline {
    agent any
    environment{
        DOCKERHUB_CREDENTIALS=credentials('dockerhub')
    }
    stages{
        stage('init'){
            steps{
                sh 'docker rm -f $(docker ps -aq) || true'
            }
        }
        stage('build'){
            steps{
                sh 'chmod +x delpoy.sh'
                sh './delpoy.sh'
            }
        }
        stage('push'){
            steps{
                sh "echo \$DOCKERHUB_CREDENTIALS_PSW | docker login -u \$DOCKERHUB_CREDENTIALS_USR --password-stdin"
                sh "docker tag trio-task-mysql:5.7 woodye14/mytriotasksql1:latest"
                sh "docker tag trio-task-flask-app woodye14/mytriotaskflask1:latest"
                sh "docker push woodye14/mytriotasksql1:latest"
                sh "docker push woodye14/mytriotasksql1:latest"
            }
        }
    }
}
