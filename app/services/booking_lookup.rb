class BookingLookup
  def self.find_by_reference_and_email(reference, email)
    return nil if reference.blank? || email.blank?

    Booking.includes(:flight, :passengers)
           .find_by(booking_reference: reference.upcase.strip, guest_email: email.downcase.strip)
  end

  def self.find_by_email(email)
    return [] if email.blank?

    Booking.includes(:flight, :passengers)
           .where(guest_email: email.downcase.strip)
           .order(created_at: :desc)
  end

  def self.validate_reference_format(reference)
    return false unless reference.is_a?(String)
    reference.match?(/\A[A-Z0-9]{6}\z/)
  end

  def self.mask_email(email)
    return "" if email.blank?

    local, domain = email.split("@")
    masked_local = local[0] + "*" * (local.length - 2) + local[-1] if local.length > 2
    "#{masked_local}@#{domain}"
  end
end
