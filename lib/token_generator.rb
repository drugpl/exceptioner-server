require 'digest/sha1'

module TokenGenerator
  def self.generate_token
    Digest::SHA1.hexdigest("#{Time.now.to_i}#{Rails.application.config.secret_token}")
  end
end
