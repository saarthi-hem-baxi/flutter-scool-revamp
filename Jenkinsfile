// pipeline {
//     agent any

//     stages {
//         stage('Checkout') {
//             steps {
//                 checkout scm
//             }
//         }

//         stage('Use .env from S3') {
//             steps {
//                 script {
//                     sh 'aws s3 cp s3://saarthidevenvironment/mobile-applications/students/.env /var/lib/jenkins/workspace/student-revamp/.env'
//                     sh 'aws s3 cp s3://saarthidevenvironment/mobile-applications/students/.env.review /var/lib/jenkins/workspace/student-revamp/.env.review'
//                 }
//             }
//         }

//         stage('Build APK Release') {
//             steps {
//                 script {
//                     sh 'sudo flutter build apk --release'
//                 }
//             }
//             post {
//                 always {
//                     archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/app-release.apk', allowEmptyArchive: true
//                 }
//             }
//         }
//     }
// }
pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Use .env from S3') {
            steps {
                script {
                    sh 'aws s3 cp s3://saarthidevenvironment/mobile-applications/students/.env /var/lib/jenkins/workspace/student-revamp/.env'
                    sh 'aws s3 cp s3://saarthidevenvironment/mobile-applications/students/.env.review /var/lib/jenkins/workspace/student-revamp/.env.review'
                }
            }
        }

        stage('Flutter Setup') {
            steps {
                script {
                    sh 'sudo flutter clean'
                    sh 'sudo flutter pub get'
                }
            }
        }

        stage('Build APK Release') {
            steps {
                script {
                    sh 'sudo flutter build apk --release'
                }
            }
            post {
                always {
                    archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/app-release.apk', allowEmptyArchive: true
                }
            }
        }
    }
}

