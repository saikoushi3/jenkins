output "jenkins_server_public_ip" {
  description = "The public IP address of the Jenkins server."
  value       = aws_instance.jenkins_server.public_ip
}

output "jenkins_url" {
  description = "The URL to access Jenkins."
  value       = "http://${aws_instance.jenkins_server.public_ip}:8080"
}
