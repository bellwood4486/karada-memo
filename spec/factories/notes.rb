def rand_time(from, to = Time.zone.now)
  Time.zone.at(rand(from.to_f..to.to_f))
end

FactoryBot.define do
  factory :note do
    # TODO: ランダムの開始は外から差し替えられたほうが使いやすい。やり方調べる。
    noted_at { rand_time(5.year.ago) }
    detail '熱が○○度出ている。'
    association :body
  end
end
