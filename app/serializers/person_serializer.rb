class PersonSerializer < ActiveModel::Serializer
  attributes :id, :name, :position, :start_date, :end_date, :board_member
end
