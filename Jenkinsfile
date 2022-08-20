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
        stage('Nuget restore') {
            steps {
                bat 'dotnet restore'
            }
        }
        stage('Code build') {
            steps {
                bat 'dotnet build'
            }
        }
    }
}
