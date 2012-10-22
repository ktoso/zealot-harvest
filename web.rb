require 'sinatra'
require 'date'
require 'harvested'
require 'yaml'

def funky_magic t
  for i in 0..t.size-1
    x = t[i].ord
    x = (x-97+13) % 26+97 if x.between?(97,122)
    x = (x-65+13) % 26+65 if x.between?(65,90)
    t[i] = x.chr
  end
  return t
end

conf = YAML.load_file('conf.yml')
HARVEST = Harvest.hardy_client(conf['domain'], conf['email'], conf['pass'])

get '/' do
  now = DateTime.now
  @week_stats = timesheet(this_week_days.first, this_week_days.last)
  @prev_week_stats = timesheet(prev_week_days.first, prev_week_days.last)
  @month_stats = timesheet(this_month_days.first, this_month_days.last)

  # modify if you work 1/2 or 4/5-time
  @week_target_time = 40
  @week_target_mins = @week_target_time * 60

# weeks
  @week_total_hours = @week_stats.map { |day| day[:hours].to_f }.inject{ |l, r| l + r }
  @week_total_mins = @week_total_hours * 60
  @week_total_time = "#{'%.2f' % @week_total_hours}h"
  @week_green = @week_total_mins >= @week_target_mins

  @prev_week_total_hours = @prev_week_stats.map{ |day| day[:hours].to_f }.inject{ |l, r| l + r }
  @prev_week_total_mins = @prev_week_total_hours * 60
  @prev_week_total_time = "#{'%.3f' % @prev_week_total_hours}h"
  @prev_week_green = @prev_week_total_mins >= @week_target_mins

# months
  @month_target_time = 4 * @week_target_time
  @month_target_mins = 4 * @week_target_mins

  @month_total_hours = @month_stats.map{ |day| day[:hours].to_f }.inject{ |l, r| l + r }
  @month_total_mins = @month_total_hours * 60
  @month_total_time = "#{'%.3f' % @month_total_hours}h"
  @month_green = @month_total_mins >= @month_target_mins

  erb :main
end

def timesheet(from, to)
  yap = HARVEST.projects.all.select { |p| p.code =~ /YAP/ }
  HARVEST.reports.time_by_project(yap.first, Time.parse(from[:when]), Time.parse(to[:when]))
end

def this_week_days
  today = Date.today

  week_days today
end

def prev_week_days
  today_one_week_ago = Date.today - 6

  week_days today_one_week_ago
end

def week_days(day_in_target_week)
  week = []

  if day_in_target_week.wday == 0
    monday = day_in_target_week - 6
    sunday = day_in_target_week
  else
    monday = day_in_target_week - day_in_target_week.wday + 1
    sunday = monday + 6
  end

  monday.upto sunday do |day|
    week << { :label => day.strftime('%A'), :when => day.to_s }
  end

  week
end

def this_month_days
  today = Date.today
  first_day = today.prev_day (today.day + 1) # goto beginning of month

  first_week = week_days first_day + 7
  second_week = week_days first_day + 14
  third_week = week_days first_day + 21
  fourth_week = week_days first_day + 28

  first_week + second_week + third_week + fourth_week
end


__END__
