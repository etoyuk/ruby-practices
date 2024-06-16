#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []

scores.each do |s|
  # ストライクが出た場合
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = shots.each_slice(2).to_a

# ストライクの場合のポイント計算用メソッド
def calculate_strike_point(frames, idx)
  if frames[idx + 1][0] == 10
    frames[idx + 1][0] + frames[idx + 2][0] if frames[idx + 2]
  else
    frames[idx + 1][0] + frames[idx + 1][1]
  end
end

# 合計ポイントの計算
point = 0
frames.each_with_index do |frame, i|
  point += frame.sum
  if i < 9 # 10フレーム目以外
    if frame[0] == 10 # ストライク
      point += calculate_strike_point(frames, i)
    elsif frame.sum == 10 # スペア
      point += frames[i + 1][0]
    end
  end
end
puts point
