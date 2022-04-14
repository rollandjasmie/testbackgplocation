CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['ACCESS_KEY'],
    :aws_secret_access_key  => ENV['SECRET_KEY'],
    :region                 => ENV['DO_REGION'],
    :endpoint               => ENV['SPACE_ENDPOINT']
  }
  config.fog_directory  = ENV['BUCKET_NAME']
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  config.fog_public = false
  config.asset_host = "https://#{config.fog_directory}.fra1.digitaloceanspaces.com"
  config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' }
end