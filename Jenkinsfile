pipeline {
    agent any

    parameters {
        string(name: 'version', defaultValue: '3.0', description: 'Version variable to pass to Terraform')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
        choice(name: 'action', choices: ['', 'plan-apply', 'destroy'], description: 'Select Destroy or Apply')

    }
    
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        TF_IN_AUTOMATION      = '1'
    }

    stages {
        stage('Plan') {
            steps {
                script {
                    currentBuild.displayName = params.version
                }
                sh 'terraform init -input=false'
                sh "terraform plan -lock=false -input=false -out=tfplan -no-color"
                sh 'terraform show -lock=false -no-color tfplan > tfplan.txt'
            }
        }

        stage('Approval') {
            when {
                not {
                    equals expected: true, actual: params.autoApprove
                }
            }

            steps {
                script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Do you want to apply the plan?",
                        parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
            }
        }
 stage('Confirmación de accion') {
            steps {
                script {
                    def userInput = input(id: 'confirm', message: params.ACCION + '?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
                }
            }
        }
        
        stage('Terraform apply or destroy ----------------') {
            steps {
               sh 'echo "Terraform apply or destroy"'
            script{  
                if (params.action == "destroy"){
                         sh 'echo  ' + params.action   
                         sh 'terraform destroy -lock=false tfplan'
                } else {
                         sh ' echo '+ params.action                
                         sh 'terraform apply -lock=false -input=false tfplan'  
                }  // if

            }
            }
        }
        stage('Apply') {
            steps {
                sh "terraform apply -lock=false -input=false tfplan"
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'tfplan.txt'
        }
    }
}
