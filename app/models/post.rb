class Post < ActiveRecord::Base
    validates :title, presence: true
    validates(:content, { :length => { :minimum => 250 } })
    validates(:summary, { :length => { :maximum => 250 } })
    #validates_inclusion_of :format, in: %w( jpg gif png ), message: "extension %{value} is not included in the list"
    validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
    validate :clickbait_enough?

   PHRASES = [
    /Won't Believe/i,
    /Top [0-9]*/i,
    /Secret/i,
    /Guess/
  ]

    def clickbait_enough?
    if PHRASES.none? {|cb| cb.match title}
      errors.add(:title, "must be clickbait")
    end
  end

end
