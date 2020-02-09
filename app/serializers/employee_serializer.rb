class EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :name, :position, :hired_in, :start, :end_d, :board, :count
end
