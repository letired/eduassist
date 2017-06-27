json.extract! @school_class, :id, :name, :description
json.students @school_class.students do |student|
  json.extract! student, :id, :first_name, :last_name, :bio, :birthday
end
