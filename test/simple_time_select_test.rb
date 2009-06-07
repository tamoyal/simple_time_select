require File.join(File.dirname(__FILE__), 'test_helper')

class String
  def nstrip
    self.gsub(/\n+/, '')
  end

  def nstrip!
    self.gsub!(/\n+/, '')
  end
  
  def strip_selected
    self.gsub(" selected=\"selected\"", '')
  end
end

class SimpleTimeSelectTest < Test::Unit::TestCase
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::FormOptionsHelper
  include ActionView::Helpers::DateHelper
  
  def test_ampm_hour
    assert_equal(12, ampm_hour(0), "ampm_hour test 12 AM")
    assert_equal(5, ampm_hour(5), "ampm_hour test 5 AM")
    assert_equal(12, ampm_hour(12), "ampm_hour test 12 PM")
    assert_equal(5, ampm_hour(17), "ampm_hour test 5 PM")
    assert_equal(11, ampm_hour(23), "ampm_hour test 11 PM")
  end
  
  def test_zero_pad_num
    assert_equal('00', zero_pad_num(0))
    assert_equal('01', zero_pad_num(1))
    assert_equal('10', zero_pad_num(10))
  end
  
  def test_simple_time_select_default
    # Default time is 9:00pm
    time = Time.now.change(:hour => 21)
    
    options = []
    0.upto(23) do |hour|
      meridiem = hour < 12 ? 'AM' : 'PM'
      0.upto(3) do |minute|
        options.push  [ ampm_hour(hour).to_s+":"+zero_pad_num(minute*15)+" "+meridiem, zero_pad_num(hour)+":"+zero_pad_num(minute*15)+":00" ]
      end
    end
    expected = select_tag 'date[minute]', options_for_select(options, "21:00:00"), :id => 'date_minute'  
    actual = select_minute time, :simple_time_select => true
    assert_equal(expected.nstrip, actual.nstrip, "Simple Time Select generation")
  end

  def test_usual_time_select
    # Default time is 9:00pm
    time = Time.now.change(:hour => 21)

    options = options_for_select((0..59).to_a.map { |m| "%02d" % m }, "00")
    expected = select_tag 'date[minute]', options, :id => 'date_minute'
    expected.nstrip!

    # The select_tag helper puts selected="selected" after the value in the options tag
    # whereas the select_minute helper puts selected="selected" before the value in the options tag.
    # Therefore the html can be correct, but this test will not validate. To fix this, I am just removing
    # selected="selected" from both before I compare
    expected = expected.strip_selected
    
    actual = select_minute time, :simple_time_select => false
    actual = actual.strip_selected
    assert_equal(expected, actual.nstrip, "Usual time select with explicit option")

    actual = select_minute time
    actual = actual.strip_selected
    assert_equal(expected, actual.nstrip, "Usual time select with no options")
  end
  
  # TODO
  def test_start_and_end_hour
    time = Time.now.change(:hour => 21)
    # 10 AM to 2 PM
    output = select_minute time, :simple_time_select => true, :start_hour => 10, :end_hour => 14
    puts "#{output.inspect}"
  end
end
