class StaffSerializer < ActiveModel::Serializer
  attributes :id, :name, :position, :start_year, :start_quarter, :end_year, :end_quarter, :board, :cheif, :president, :int
end
