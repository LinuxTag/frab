class LinuxTag::VccRoom < VccDatabase

  self.table_name = 'room'

  has_many :events, class_name: "LinuxTag::VccEvent", foreign_key: "room"

  def frab_room_attributes(conference)
    {
      conference: conference,
      name:       '%s (%s)' % [comment, name],
      size:       occupancy,
      public:     true,
      rank:       id,
    }
  end
  
end

