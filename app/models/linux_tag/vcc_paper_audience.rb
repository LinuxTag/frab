class LinuxTag::VccPaperAudience < VccDatabase

  self.table_name = 'audience'

  has_many :papers, class_name: "LinuxTag::VccPaper", foreign_key: "audience"

end

