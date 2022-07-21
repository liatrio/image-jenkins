## What is the image for?
The intended purpose of this image is for it to be used as a Jenkins master which will execute Jenkins pipelines by means of different Jenkins agents. These agents are intended to be added to the Jenkins configuration as [Kubernetes](ihttps://plugins.jenkins.io/kubernetes/) pod templates by means of Jenkins Configuration as Code ([JCasC](https://github.com/jenkinsci/configuration-as-code-plugin/blob/master/README.md)).

First, an example (using `image-builder-ruby`) of configuring the pod templates (as code) in yaml so the Jenkins master is able to create pods in the Kubernetes cluster using said template.

```yaml
jenkins:
  clouds:
    - kubernetes:
        name: "kubernetes"
        templates:
          - name: "image-builder-ruby"
            label: "image-builder-ruby"
            nodeUsageMode: NORMAL
            containers:
              - name: "image-ruby"
                image: "ghcr.io/liatrio/image-builder-ruby:${builder_images_version}"
```
And then specifying the agent in the Jenkinsfile for an example step.

```jenkins
stage('Build') {
  agent {
    label "image-builder-ruby"
  }
  steps {
    container('image-ruby') {
      sh "echo 'puts "Hello Ruby"' > hello.rb"
      ruby hello.rb
    }
  }
}

For Jenkins agents that are intended to be used with this master, see our various `image-builder` repositories.

## What is installed on this image?
- Version [2.348](https://www.jenkins.io/download/) of Jenkins.
- Various Jenkins plugins as defined by plugins.txt
