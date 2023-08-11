pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build APK Release') {
            steps {
                script {
                    //sh 'sudo flutter update-packages --force-upgrade'
                    sh 'sudo flutter build apk --release'
                }
            }
            post {
                always {
                    archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/app-release.apk', allowEmptyArchive: true
                }
            }
        }

        stage(' Use.env from S3') {
            steps {
                script {
                    sh 'aws s3 cp .env s3://saarthidevenvironment/mobile-applications/students/.env /var/lib/jenkins/workspace/student-flutter-pipeline/'
                    sh 'aws s3 cp .env s3://saarthidevenvironment/mobile-applications/students/.env.review /var/lib/jenkins/workspace/student-flutter-pipeline/'
                }
            }
        }
    }
}

