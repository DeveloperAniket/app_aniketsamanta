pipeline {
    agent any

    options {
        timestamps()
        timeout(time: 1, unit: 'HOURS')
        buildDiscarder(logRotator(daysToKeepStr: '10', numToKeepStr: '20'))
        parallelsAlwaysFailFast()
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
        stage('Code build') {
            steps {
                echo  ' ##### Code build starts ##### '
                bat 'dotnet build'
            }
        }
        stage('Test Execution') {
            when {
                branch 'master'
            }
            steps {
                echo  ' ##### Test Execution starts ##### '
                bat 'dotnet test --logger:trx;LogFileName=appaashishsawanttest.xml'
            }
        }
        stage('Release Artifacts') {
            when {
                branch 'develop'
            }
            steps {
                echo  ' ##### Release Artifacts starts ##### '
            }
        }
        stage('Kubernetes Deployment') {
            steps {
                echo  ' ##### Kubernetes Deployment startss ##### '
            }
        }
    }
}
