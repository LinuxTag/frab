class LinuxTag::VccPanel < VccDatabase

  self.table_name = 'panel'

  has_many :events, class_name: "LinuxTag::VccEvent", foreign_key: "panel"

end

