class Timer
  attr_reader :time_remaining

  def initialize(tartget_time = nil, buffer_time = 0.3)
    @tartget_time = tartget_time
    @buffer_time = buffer_time
    @start_time = Time.new
    @stop_time = nil
    @time_remaining = 0
  end

  def set_time_remaining
    return unless @tartget_time.instance_of?(Integer) || @tartget_time.instance_of?(Float)

    time_remaining = @tartget_time + @buffer_time - elapsed_time
    @time_remaining = time_remaining if time_remaining.positive?
  end

  private

  def stop
    @stop_time = Time.new
  end

  def elapsed_time
    stop
    @stop_time - @start_time
  end
end
