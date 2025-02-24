output "staging_ip" {
  value = aws_instance.staging.public_ip
}
output "production_ip" {
  value = aws_instance.production.public_ip
}