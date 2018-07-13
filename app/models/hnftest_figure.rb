class HnftestFigure < ApplicationRecord
  belongs_to :hnftest
  position_by_id={1=>'right',0=>'left'}
  def self.LEFT
    0
  end
  def self.RIGHT
    1
  end
  def self.HEART
    0
  end
  def self.FLOWER
    1
  end

  figure_by_id={0=>'heart',1=>'flower'}

end
