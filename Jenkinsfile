#!groovy
import java.text.SimpleDateFormat

// pod utilisé pour la compilation du projet
podTemplate(label: 'meltingpoc-referentiel-personnes-mock-pod', nodeSelector: 'medium', containers: [

        // le slave jenkins
        containerTemplate(name: 'jnlp', image: 'jenkinsci/jnlp-slave:alpine'),

        // un conteneur pour le build maven
        containerTemplate(name: 'gradle', image: 'elkouhen/gradle-docker', privileged: true, ttyEnabled: true, command: 'cat'),

        // un conteneur pour construire les images docker
        containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true),

        // un conteneur pour déployer les services kubernetes
        containerTemplate(name: 'kubectl', image: 'lachlanevenson/k8s-kubectl', command: 'cat', ttyEnabled: true)],

        // montage nécessaire pour que le conteneur docker fonction (Docker In Docker)
        volumes: [hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock')]
) {

    node('meltingpoc-referentiel-personnes-mock-pod') {

        def branch = env.JOB_NAME.replaceFirst('.+/', '');

        properties([
                buildDiscarder(
                    logRotator(
                        artifactDaysToKeepStr: '1',
                        artifactNumToKeepStr: '1',
                        daysToKeepStr: '3',
                        numToKeepStr: '3'
                    )
                )
            ])

        stage('checkout sources'){
            checkout scm;
        }



        container('docker') {

                stage('build docker image'){


                 

                    sh 'docker build -t registry.k8.wildwidewest.xyz/repository/docker-repository/pocs/meltingpoc-api-personnes-mock .'

                    sh 'mkdir /etc/docker'

                    // le registry est insecure (pas de https)
                    sh 'echo {"insecure-registries" : ["registry.k8.wildwidewest.xyz"]} > /etc/docker/daemon.json'

                    withCredentials([string(credentialsId: 'nexus_password', variable: 'NEXUS_PWD')]) {
                         echo "My password is '${NEXUS_PWD}'!"

                         sh "docker login -u admin -p ${NEXUS_PWD} registry.k8.wildwidewest.xyz"
                    }

                    sh 'docker push registry.k8.wildwidewest.xyz/repository/docker-repository/pocs/meltingpoc-api-personnes-mock'
                }
        }

        container('kubectl') {

            stage('deploy'){

                sh 'kubectl delete svc meltingpoc-api-personnes-mock'
                sh 'kubectl delete deployment meltingpoc-api-personnes-mock'
                sh 'kubectl create -f kubernetes/meltingpoc-api-personnes-mock.yml'

            }
        }
    }
}
