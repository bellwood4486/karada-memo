CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

CarrierWave.configure do |config|
  config.permissions = 0o600

  if Rails.env.development?
    config.storage = :file
  end
  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
  end
  if Rails.env.production?
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      region: ENV['S3_REGION'],
      aws_access_key_id: ENV['S3_ACCESS_KEY'],
      aws_secret_access_key: ENV['S3_SECRET_KEY']
    }
    config.fog_directory =  ENV['S3_BUCKET']
    # storage = :fog は fog_providerの設定より後に書く必要あり。
    # 前に書くとuninitialized constant CarrierWave::Storage::Fogがスローされる
    config.storage = :fog
  end
end
