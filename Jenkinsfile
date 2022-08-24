pipeline {
    agent any
    environment {
        Sonar_Scanner_Env = tool 'sonar_scanner_dotnet'
        Project_Key_Env = 'sonar-aniketsamanta'
    }
    options {
        timestamps()
        timeout(time: 1, unit: 'HOURS')
        buildDiscarder(logRotator(daysToKeepStr: '10', numToKeepStr: '20'))
    }
    stages {
        stage('Nuget restore') {
            steps {
                echo  ' ##### Dotnet clean starts ##### '
                bat 'dotnet clean'
                echo  ' ##### Nuget restore starts ##### '
                bat 'dotnet restore'
            }
        }
        stage('Start Sonarqube Analysis') {
            when {   branch 'master'   }
            steps {
                echo ' ##### Starting the sonar analysis ##### '
                withSonarQubeEnv('Test_Sonar') {
                    bat "dotnet ${Sonar_Scanner_Env}\\SonarScanner.MSBuild.dll begin /k:\"${Project_Key_Env}\" /d:sonar.verbose=true"
                }
            }
        }
        stage('Code build') {
            steps {
                echo  ' ##### Code build starts ##### '
                bat 'dotnet build'
            }
        }
        stage('Test Case Execution') {
            when {
                branch 'master'
            }
            steps {
                echo  ' ##### Test Execution starts ##### '
                bat 'dotnet test'
            }
        }
        stage('Stop sonarqube analysis') {
            when {
                branch 'master'
            }
            steps {
                echo ' ##### Stopping the sonar analysis ##### '
                withSonarQubeEnv('Test_Sonar') {
                    bat "dotnet ${Sonar_Scanner_Env}\\SonarScanner.MSBuild.dll end"
                }
            }
        }
        stage('Release Artifacts') {
            when {
                branch 'develop'
            }
            steps {
                echo  ' ##### Release Artifacts starts ##### Need to check '
                bat 'dotnet publish -c Release'
            }
        }
        stage('Kubernetes Deployment') {
            when { anyOf { branch 'develop'; branch 'master' } }
            steps {
                echo  " ##### Kubernetes Deployment starts for ${env.BRANCH_NAME} ##### "
                script {
                    bat 'gcloud auth login'
                    bat 'gcloud container clusters get-credentials kubernetes-cluster-aniketsamanta --region asia-south2 --project kb2cluster'
                    echo 'k8s yaml files location =>  k8s/'
                    bat 'kubectl apply -f k8s/shared-secret.yaml'
                    echo "k8s branch yaml files location =>  k8s/${env.BRANCH_NAME}/"
                    bat "kubectl apply -f k8s/${env.BRANCH_NAME}/configmap.yaml"
                    bat "kubectl apply -f k8s/${env.BRANCH_NAME}/service.yaml"
                    bat "kubectl apply -f k8s/${env.BRANCH_NAME}/deployment.yaml"
                }
            }
        }
    }
}
