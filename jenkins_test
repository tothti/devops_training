pipeline {
    agent any
    stages {
        stage('Devops From github') {
            steps {
                sh 'echo "This is my first code for jenkins"'
                sh '''
                    echo "DevOps Rocks!"
                    curl -v google.com
                '''
            }
        }
    }
}
