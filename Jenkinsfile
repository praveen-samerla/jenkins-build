pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('Docker_hub')
    }

    stages {
        stage('Display Commit Changes') {
            steps {
                script {
                    // Retrieve the commit changes
                    def changeLogSets = currentBuild.changeSets
                    for (int i = 0; i < changeLogSets.size(); i++) {
                        def entries = changeLogSets[i].items
                        for (int j = 0; j < entries.length; j++) {
                            def commit = entries[j]
                            echo "Commit by ${commit.author} on ${commit.timestamp}:"
                            echo "Message: ${commit.msg}"
                            echo "Affected files:"
                            commit.affectedFiles.each { file ->
                                echo "- ${file.editType.name} ${file.path}"
                            }
                            echo '---'
                        }
                    }
                }
            }
        }

        stage('Zip Code') {
            steps {
                script {
                    // Determine the branch name
                    def branchName = env.BRANCH_NAME ?: 'UNKNOWN_BRANCH'

                    echo "BRANCH_NAME: ${env.BRANCH_NAME}"
                    echo "Git branch: ${branchName}"

                    // Determine the zip file name based on the branch name
                    def zipFileName

                    if (branchName == 'dev-backend') {
                        zipFileName = "py_services_${env.GIT_COMMIT}.zip"
                        sh "zip -r $zipFileName ."
                    } else if (branchName == 'dev-ai') {
                        zipFileName = "js_services_${env.GIT_COMMIT}.zip"
                        sh "zip -r $zipFileName ."
                    } else {
                        // Set default branches here
                        branchName = 'dev-ai'  // Change to your desired default branch
                        zipFileName = "js_services_${env.GIT_COMMIT}.zip"
                        sh "zip -r $zipFileName ."
                    }
                }
            }
        }
    }

    post {
        success {
            script {
                // Retrieve the commit changes again
                def changeLogSets = currentBuild.changeSets
                for (int i = 0; i < changeLogSets.size(); i++) {
                    def entries = changeLogSets[i].items
                    for (int j = 0; j < entries.length; j++) {
                        def commit = entries[j]
                        echo "Commit by ${commit.author} on ${commit.timestamp}:"
                        echo "Message: ${commit.msg}"
                        echo "Affected files:"
                        commit.affectedFiles.each { file ->
                            echo "- ${file.editType.name} ${file.path}"
                        }
                        echo '---'
                    }
                }
            }
        }

        always {
            archiveArtifacts artifacts: '*.zip', allowEmptyArchive: true
        }
    }
}
