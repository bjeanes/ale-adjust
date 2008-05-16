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
  
  def +(timecode)
    seconds, frames = to_sec_and_frame(timecode)
    self.add!(seconds, frames)
  end
  
  def -(timecode)
    seconds, frames = to_sec_and_frame(timecode)
    self.add!(-seconds, -frames)
  end
  
  # this should be named nicer
  def add!(s, f=0)
    @frame = @frame + f
    @time += (s + @frame / @frames) #if the frames tick over to a new second, compensate
    @frame %= @frames
    self
  end
  
  # this should be named nicer
  def minus!(s, f=0)
    self.add!(-s, -f)
  end
  
  def to_s; @time.strftime("%H:%M:%S:#{@frame.to_s.rjust(2,'0')}"); end
  def inspect; self.to_s; end
  
  class << self
    private :new
  end
  
  protected
  def to_sec_and_frame(timecode)
    if timecode =~ /(\d\d):(\d\d):(\d\d):(\d\d)/
      hours = $1.to_i
      minutes = $2.to_i
      seconds = $3.to_i
      frames = $4.to_i
      
      seconds = seconds + minutes*60 + hours*3600
      return seconds, frames
    else
      return 0,0
    end
  end
end