class Hnftest < ApplicationRecord
  def self.HEARTS_TEST_TYPE
    0
  end
  def self.FLOWERS_TEST_TYPE
    1
  end
  def self.HEARTS_AND_FLOWERS_TEST_TYPE
    2
  end

  has_many :hnfset_hnftests
  has_many :hnfsets, through: :hnfset_hnftests
  has_many :hnftest_figures
 # type_by_id={0=>'Hearts and Flowers',1=>'Hearts',0=>'Flowers'}
end
