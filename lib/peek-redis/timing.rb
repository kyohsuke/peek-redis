module Peek
  module Redis
    module Timing
      def call(*args, &block)
        start = Time.now
        super(*args, &block)
      ensure
        duration = (Time.now - start)
        ::Redis::Client.query_time.update { |value| value + duration }
        ::Redis::Client.query_count.update { |value| value + 1 }
      end
    end
  end
end
