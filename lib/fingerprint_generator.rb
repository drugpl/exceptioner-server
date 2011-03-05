require 'digest/sha1'

module FingerprintGenerator
  def self.generate_fingerprint(*attributes)
    Digest::SHA1.hexdigest(attributes.join)
  end
end
