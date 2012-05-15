require 'test_helper'

class ArrayAutoFoldingTest < XMLObject::TestCase
  def test_array_auto_folding
    herd = XMLObject.new('<herd><sheep></sheep><sheep></sheep></herd>')
    assert_instance_of Array, herd.sheep
  end

  def test_behavior_of_auto_folded_array
    chart = XMLObject.new '<chart><axis>y</axis><axis>x</axis></chart>'

    assert_equal 'y', chart.axis[0]
    assert_equal 'y', chart.axis.first

    assert_equal 'x', chart.axis[1]
    assert_equal 'x', chart.axis.last

    assert_equal chart.axis, chart.axiss # 's' plural (naïve)
    assert_equal chart.axis, chart.axes if defined?(ActiveSupport::Inflector)
  end

  def test_behaviour_of_arrays_with_zero_and_one_child
    herd = XMLObject.new('<herd><goats>' + \
      '<goat>' + \
        '<eyes><eye>right</eye><eye>left</eye></eyes>' + \
        '<names></names>' + \
      '</goat>' + \
    '</goats></herd>')

    assert_equal 1, herd.goats.length

    goat = herd.goats.first
    assert_equal 2, goat.eyes.length
    assert_equal 0, goat.names.length
    assert_equal 'left', goat.eyes.first
  end
end