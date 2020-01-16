output "tomcat_ip" {
  value = "${aws_eip.tomcat-eip.public_ip}"
}
