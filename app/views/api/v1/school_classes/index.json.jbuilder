json.array! @school_classes do |school_class|
  json.extract! school_class, :id, :name, :description
end
