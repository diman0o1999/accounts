class AvatarUploader < BaseUploader

  version :large do
    process resize_to_fit: [500, 500]
  end
  version :thumb do
    process resize_to_fit: [80, 80]
  end

  def default_url
    #ActionController::Base.helpers.asset_path("fallbacks/user/#{version_name}/default.jpg")
    "/fallbacks/user/#{version_name}/default.jpg"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

end
