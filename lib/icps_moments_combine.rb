require File.expand_path('../../config/environment', __FILE__)

icps = Study.where("name like 'ICPS T2 2019'").first


icps.get_moments().delete_all

baseline_from = Date.new(2019,04,04)
baseline_until =Date.new(2019,06,24)
baseline =Moment.create(from:baseline_from, until: baseline_until, study:icps)

followup_from = Date.new(2019,10,01)
followup_until = Date.new(2019,12,31)

followup = Moment.create(from: followup_from, until: followup_until, study:icps)
#repair the followup_1
#




