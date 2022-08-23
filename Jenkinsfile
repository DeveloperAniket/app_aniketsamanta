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
                echo 'Branch Name...' + env.BRANCH_NAME
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
