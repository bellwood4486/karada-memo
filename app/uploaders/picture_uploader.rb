class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  SIZE_LIMIT = 5.megabytes

  # ストレージの設定はconfig/initializers/carrierwave.rb側で定義

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url(*args)
    '/images/fallback/' + [version_name, 'default.png'].compact.join('_')
  end

  process resize_to_limit: [800, 800]

  version :thumb do
    process resize_to_fill: [400, 400]
  end

  # Override the filename of the uploaded files.
  def filename
    "#{secure_token(10)}.#{file.extension}" if original_filename.present?
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w[jpg jpeg gif png]
  end

  def size_range
    1..SIZE_LIMIT
  end

  private

  def secure_token(length = 16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.hex(length / 2))
  end
end
