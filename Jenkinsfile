pipeline {
    agent any
    stages {
        stage('Build Images') {
            steps {
                sh '''
                docker build -t selvasuba/LBG-PYTHON-db:latest ./db
                docker build -t selvasuba/LBG-Python-db:4{BUILD_NUMBER} ./db
                docker build -t selvasuba/LBG-Python-app:latest ./flask-app
                docker build -t selvasuba/LBG-Python-app:${BUILD_NUMBER} ./flask-app
                docker build -t selvasuba/LBG-Python-db:latest ./nginx
                docker build -t selvasuba/LBG-Python-app:${BUILD_NUMBER} ./nginx
                
                 '''
            }  
        }
        stage('Push Images'){
            steps{
                sh'''
                
                docker push selvasuba/LBG-Python-db
                docker push selvasuba/LBG-Python-db:${BUILD_NUMBER}
                docker push selvasuba/LBG-Python-app
                docker push selvasuba/LBG-Python-app:${BUILD_NUMBER}
                docker push selvasuba/LBG-Python-rp
                docker push selvasuba/LBG-Python-rp:${BUILD_NUMBER}
                
                
                '''
            }
        }
        stage('Deploy containers') {
            steps{
                sh '''

                ssh jenkins@selva-selva1 << EOF
                docker pull selvasuba/LBG-Python-app
                docker pull selvasuba/LBG-Python-dp
                docker pull selvasuba/LBG-Python-rp
                docker netwrok create trio
                docker volume create trio
                docker run -d -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} -v --netwrok trio --name mysql selvasuba/LBG-Python-db
                docker run -d -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} --netwrok trio --name flash-app selvasuba/LBG-Python-db
                docker run -d -p 80:80 --network trio  --name ngnix selvasuba/LBG-Python-rp
                
                '''
            }

        }
    }
}
