Aws.config = {
  credentials: Rails.application.secrets['aws'],
  region: 'us-east-1'
}
