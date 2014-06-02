class Question < ActiveRecord::Base

  validates :title, :description, presence: {message: "must be provided"}  #validates that the title is what it should be
  #validate :stop_words

  before_save :sanitize_title

    #scope :recent_ten, -> {order("created_at DESC").limit(10)}
    #scope :recent, ->{where("created_at > ?" Time.now-3.days)}

      # def self.recent
      #     where("created_at > ?" Time.now-3.days)
      # end

      def self.all_but(ids)
        where("id NOT IN (?)", ids)
      end

  private

    def stop_words
      if title.include?"question"
      errors.add(:title, "can't contain the word 'question'")    
      end
    end

    def sanitize_title
      self.title = title.squeeze(" ").strip.capitalize
    end

end
