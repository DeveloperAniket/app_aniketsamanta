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
                branch 'develop'
            }
            steps {
                echo  ' ##### Test Execution starts ##### '
            }
        }
    }
}
