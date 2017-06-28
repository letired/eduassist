json.array! @assignments do |assignment|
  json.extract! assignment, :id, :name, :category, :max_points
end
