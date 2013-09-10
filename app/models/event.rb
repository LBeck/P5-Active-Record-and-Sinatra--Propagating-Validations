class Event < ActiveRecord::Base

# Add validations to the Event model and show appropriate messages to the user
# when the validations fail. Prevent Events from being saved when:
# a. The events date is empty, in the past, or is not valid.
# b. The events title is already taken or empty.
# c. The event organizers name is empty.
# d. The event organizers email address is invalid.

  validates_presence_of :date, :title, :organizer_name
  validate :date_cannot_be_in_the_past
  validate :title, uniqueness: true
  validates :organizer_email, format: {with: /.+@+\w..{2,}/, message: "only allows valid emails"}

  def date_cannot_be_in_the_past
    if date.present? && date < Date.today
      errors.add(:expiration_date, "can't be in the past")
    end
  end

  def self.create(params)
    event = Event.new(params)
    event.save
    event
  end



end
