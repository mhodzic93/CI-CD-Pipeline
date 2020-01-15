# Jenkins
Builds a Jenkins server running on AWS using Terraform

Navigate to `Manage Jenkins` > `Global Tool Configuration` > `JDK`
1. Configure JDK by setting JDK Name to `JAVA_HOME`
2. Update Java_Home path to the path of JAVA_HOME which can be found in `/etc/profile`.
The value will be similar to `/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.232.b09-0.48.amzn1.x86_64`

Navigate to `Manage Jenkins` > `Global Tool Configuration` > `Git`
1. Update Git Name to `github`

Navigate to `Manage Jenkins` > `Global Tool Configuration` > `Maven` > `Maven Installations`
1. Set Name to `M2_HOME`
2. Update Java_Home path to `/opt/maven`
