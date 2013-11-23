require "securerandom"

class UID
  def initialize
    @uid = SecureRandom.uuid.upcase
  end

  def to_s
    @uid
  end
end
