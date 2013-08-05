class LinuxTag::VccAuthorshipStatus < VccDatabase

  self.table_name = 'status_authorship'

  has_many :authorships, class_name: "LinuxTag::VccAuthorship", foreign_key: "status"

end

