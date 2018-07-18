// Global variable section for Wordpress Deployment Pipeline

def registry = '833089950506.dkr.ecr.us-east-1.amazonaws.com'
def app = 'demo-wp'
def tag = env.BUILD_NUMBER

try {
    
    node {
        
        stage('Checkout')
            git 'https://github.com/Anilborra25/wordpress-ecs.git'

        docker.withRegistry("https://${registry}", 'ecr:us-east-1:ecs-wp-demo-cred') {
        
        stage('Build')
            def appImage = docker.build("${registry}/${app}:${tag}")
              
        stage('Test')
            // Docker Run Tests can be integrated here

        stage('Publish')
            appImage.push()
        }
        
        stage 'Deploy: Dev'
            // Dev deployment logic goes here

        stage ('Stage Approval')
            input message: 'Approve Stage Deployment? (App/QA Owner)', ok: 'Approve',  submitterParameter: 'submitter', submitter: "admin,abbora"
        
        stage('Deploy: Stage')
            //Stage deployment goes here

        stage ('Prod Approval')
            input message: 'Approve Prod Deployment? (App/QA Owner)', ok: 'Approve',  submitterParameter: 'submitter', submitter: "admin,abbora"
        
        stage('Deploy: Prod')
            //Prod deployment goes here
    }
} catch (err) {
    currentBuild.result = "FAILED"
    throw err    
} 