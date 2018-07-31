class HnftestsController < ApplicationController

  def get_current_data
    hnfset=Hnfset.find_by(current:true)

    puts hnfset.hnftests
    hnfs=hnfset.hnftests


    hnfset=hnfset.as_json
    hnfset[:set]=[]
    hnfs.each do |hnf|

      sequence=hnf.hnftest_figures
      hnf=hnf.as_json
      hnf[:sequence]=sequence
      hnfset[:set].append(hnf)
    end
    return hnfset
  end
end
