#!/usr/bin/env ruby
require 'date'
require 'optparse'

# オプションが入力されなかった場合の年月を今月に設定する
month = Date.today.month
year = Date.today.year

# -mで月を、-yで年を指定できるようにする
opt = OptionParser.new

opt.on('-m [VAL]') do |m|
  month = m.to_i
end
opt.on('-y [VAL]') do |y|
  year = y.to_i
end

opt.parse!

# 今月の最初の日と最後の日を求める
first_day = Date.new(year,month, 1)
last_day = Date.new(year,month, -1)

# カレンダーのヘッダーを出力する（月の名前・曜日の名前）
mon = Date.new(year,month)
puts mon.strftime('%b').center(20)

puts "日 月 火 水 木 金 土"

# 初週のスペースを出力（日曜始まりであればスペースを出力しない）
day_of_week = first_day.wday.to_i
print '   '*day_of_week

# 各日付を出力する
number_of_last_days = last_day.day
(1..number_of_last_days).each do |number_of_last_day|
  print number_of_last_day.to_s.rjust(2)+' '
  day_of_week+=1
  # 7日分日付の数字が出力されたら改行する
  if day_of_week % 7 == 0
    print "\n"
  end
end

# 最終週の改行を出力する
puts "\n" unless day_of_week % 7 == 0
