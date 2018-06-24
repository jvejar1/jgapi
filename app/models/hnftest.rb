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


  def self.TEST_NAME_BY_NUMBER
    {Hnftest.HEARTS_TEST_TYPE=>"Corazones",Hnftest.FLOWERS_TEST_TYPE=>"Flores",Hnftest.HEARTS_AND_FLOWERS_TEST_TYPE=>"Corazones y Flores"}
  end

  has_many :hnfset_hnftests
  has_many :hnfsets, through: :hnfset_hnftests
  has_many :hnftest_figures
  default_scope { order(hnf_type: :asc) }
 # type_by_id={0=>'Hearts and Flowers',1=>'Hearts',0=>'Flowers'}
end
