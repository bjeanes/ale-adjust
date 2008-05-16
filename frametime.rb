require 'time'

class FrameTime
  def initialize(time, frame, frames=25)
    @time = time
    @frame = frame.to_i
    @frames = frames.to_i
  end
  
  def self.parse(str, frames=25)
    if str =~ /(\d\d:\d\d:\d\d):(\d\d)/
      time = Time.parse($1)
      frame = $2
      new(time, frame, frames)
    else
      nil
    end
  end
  
  def add(s, f=0)
    @frame = @frame + f
    @time += (s + @frame / @frames)
    @frame %= @frames
    self
  end
  
  def minus(s, f=0)
    self.add(-s, -f)
  end
  
  def to_s; @time.strftime("%H:%M:%S:#{@frame.to_s.rjust(2,'0')}"); end
  def inspect; self.to_s; end
end