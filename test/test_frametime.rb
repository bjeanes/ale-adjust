require 'test/unit'
require 'frametime'

class TestFrameTime < Test::Unit::TestCase
  
  def initialize(*args)
    super(*args)
    
    @tc  = "12:05:10:01"
    @tc2 = "12:05:10:02"
    @tc3 = "12:05:11:02"
    @tc4 = "10:04:11:02"
  end
  
  def test_parses_timecode_correctly
    ft = FrameTime.parse(@tc)
    assert_equal(ft.to_s, @tc)
  end
  
  def test_adds_frame_using_number
    ft = FrameTime.parse(@tc)
    ft.add!(0,1)
    assert_equal(ft.to_s, @tc2)
  end
  
  def test_adds_frame_using_timecode
    ft = FrameTime.parse(@tc)
    ft + "00:00:00:01"
    assert_equal(ft.to_s, @tc2)
  end
  
  def test_adds_second_and_frame_using_numbers
    ft = FrameTime.parse(@tc)
    ft.add!(1,1)
    assert_equal(ft.to_s, @tc3)
  end
  
  def test_minuses_two_hours_and_one_minute_using_timecode
    ft = FrameTime.parse(@tc3)
    ft - "02:01:00:00"
    assert_equal(ft.to_s, @tc4)
  end
end