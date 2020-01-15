import jenkins.model.Jenkins
import jenkins.model.JenkinsLocationConfiguration

def jenkinsParameters = [
  email:  '{{JENKINS_EMAIL}}',
  url:    'https://{{PUBLIC_IP}}:8080'
]

def jenkinsLocationConfiguration = JenkinsLocationConfiguration.get()
jenkinsLocationConfiguration.setUrl(jenkinsParameters.url)
jenkinsLocationConfiguration.setAdminAddress(jenkinsParameters.email)
jenkinsLocationConfiguration.save()