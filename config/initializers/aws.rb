aws_secrets = Rails.application.secrets['aws']

Aws.config = {
  credentials: Aws::Credentials.new(
    aws_secrets['credentials']['access_key_id'],
    aws_secrets['credentials']['secret_access_key']
  ),
  region: aws_secrets['region']
}
