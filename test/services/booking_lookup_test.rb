require "test_helper"

class BookingLookupTest < ActiveSupport::TestCase
  test "finds booking by correct reference and email" do
    flight = flights(:one)
    booking = Booking.create!(
      flight: flight,
      guest_checkout: true,
      guest_email: "test@example.com",
      phone: "+1234567890",
      booking_reference: "TEST123"
    )
    booking.passengers.create!(
      name: "John Doe",
      email: "john@example.com"
    )

    result = BookingLookup.find_by_reference_and_email("TEST123", "test@example.com")
    assert_equal booking.id, result.id
  end

  test "returns nil with incorrect reference" do
    result = BookingLookup.find_by_reference_and_email("WRONG12", "test@example.com")
    assert_nil result
  end

  test "returns nil with incorrect email" do
    result = BookingLookup.find_by_reference_and_email("ABC123", "wrong@example.com")
    assert_nil result
  end

  test "finds bookings by email" do
    flight = flights(:one)
    booking = Booking.create!(
      flight: flight,
      guest_checkout: true,
      guest_email: "test@example.com",
      phone: "+1234567890",
      booking_reference: "TEST456"
    )

    result = BookingLookup.find_by_email("test@example.com")
    assert_equal 1, result.count
    assert_equal booking.id, result.first.id
  end

  test "validates reference format" do
    assert BookingLookup.validate_reference_format("ABC123")
    assert BookingLookup.validate_reference_format("A1B2C3")
    refute BookingLookup.validate_reference_format("abc123")
    refute BookingLookup.validate_reference_format("AB123")
    refute BookingLookup.validate_reference_format("ABCDEFG")
  end

  test "masks email correctly" do
    masked = BookingLookup.mask_email("test@example.com")
    assert_equal "t**t@example.com", masked

    masked_short = BookingLookup.mask_email("ab@example.com")
    assert_equal "ab@example.com", masked_short
  end
end
