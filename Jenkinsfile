pipeline{
    agent any
    tools{
        terraform 'terraform'
        ansible 'Ansible2'
    }
    stages{
        stage('git checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/Dhruvp-11/vault.git' //get the files from github repo
            }
        }
        stage('terraform initialization'){
            steps{
                    sh 'terraform init'  // terraform initialization
            }
        }
        stage("terraform plan"){
            steps{
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'TD',
                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {  
                    sh 'terraform plan -out=plan.txt'  //running plan with aws credentials 
                }
            }
        }
        stage("terraform apply"){
            steps{
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: '6',
                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    sh 'terraform ${Action} --auto-approve'    //running apply with choice parameter apply/destory with aws credentials 
                }
            }
        }
        stage("IP addition in host file"){
            when {
                expression {params.Action == 'apply'}  // runs only when choice parameter is Apply
            }
            steps{
                sh """terraform output | grep -Eo '[[:digit:]]{1,3}\\.[[:digit:]]{1,3}\\.[[:digit:]]{1,3}\\.[[:digit:]]{1,3}' >> hosts.ini"""
            } // get IP and adde into hosts file for ansible 
        }
        stage('ansible playbook'){
            when {
                expression {params.Action == 'apply'}
            }
            steps{
                ansiblePlaybook become: true, credentialsId: 'ID', disableHostKeyChecking: true, installation: 'Ansible2', inventory: 'hosts.ini', playbook: 'playbook.yaml'
            } // running Ansible playbook with security key for AWS instance to install vault
        }
    }
}