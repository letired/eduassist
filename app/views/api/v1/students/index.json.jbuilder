json.array! @students do |student|
  json.extract! student, :id, :first_name, :last_name, :bio, :birthday
end
