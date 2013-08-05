class LinuxTag::VccEventType < VccDatabase

  self.table_name = 'type_event'

  has_many :events, class_name: "LinuxTag::VccEvent", foreign_key: "event_type"

end

