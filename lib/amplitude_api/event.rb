class AmplitudeAPI
  # AmplitudeAPI::Event
  class Event
    # @!attribute [ rw ] options
    #   @return [ Hash ] the parameters to be sent to Amplitude
    attr_accessor :options

    # Create a new Event
    def initialize(opts)
      self.options = opts
      self.options[:time] = formatted_time(opts[:time]) if opts[:time]
    end

    def user_id=(value)
      @user_id =
        if value.respond_to?(:id)
          value.id
        else
          value || AmplitudeAPI::USER_WITH_NO_ACCOUNT
        end
    end

    # @return [ Hash ] A serialized Event
    #
    # Used for serialization and comparison
    def to_hash
      self.options
    end

    # @return [ true, false ]
    #
    # Compares +to_hash+ for equality
    def ==(other)
      if other.respond_to?(:to_hash)
        to_hash == other.to_hash
      else
        false
      end
    end

    private

    def formatted_time(time)
      time.to_i * 1_000
    end
  end
end
