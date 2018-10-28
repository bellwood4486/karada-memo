# frozen_string_literal: true

def clear_model_classes(model_classes)
  model_classes.each { |clazz| clazz.try(:destroy_all) }
  puts "clear: #{model_classes.join(', ')}"
end

def puts_user_info(user)
  puts user.inspect
end

puts '-- seed'
clear_model_classes [User, Body, Family, Note]

test1 = FactoryBot.create(:user, email: 'demo1@example.com', nickname: 'デモユーザー1')
FactoryBot.create(:body, :with_notes, family: test1.family, note_count: 0)
FactoryBot.create(:body, :with_notes, family: test1.family, note_count: 3)
FactoryBot.create(:body, :with_notes, family: test1.family, note_count: 20)
puts_user_info test1

test2 = FactoryBot.create(:user, email: 'demo2@example.com', nickname: 'デモユーザー2')
FactoryBot.create(:body, :with_notes, family: test2.family, note_count: 10)
puts_user_info test2

admin = FactoryBot.create(:user, email: 'admin@example.com', nickname: '管理者')
admin.add_role :admin
puts_user_info admin

50.times do
  puts_user_info FactoryBot.create(:user)
end
