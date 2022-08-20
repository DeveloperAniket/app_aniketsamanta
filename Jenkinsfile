pipeline {
    agent any
    environment {
        MSBUILD_HOME = tool 'VisualStudio2022'
        VSTEST_CONSOLE_HOME = tool 'vstest.console'
    }
    options {
        timestamps()
        timeout(time: 1, unit: 'HOURS')
        buildDiscarder(logRotator(daysToKeepStr: '10', numToKeepStr: '20'))
        parallelsAlwaysFailFast()
    }
    stages {
        stage('Checkout')
        {
            steps
            {
                echo  ' ##### checkout starts ##### '
                checkout scm
            }
        }
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
    }
}
