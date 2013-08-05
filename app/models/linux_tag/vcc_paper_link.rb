class LinuxTag::VccPaperLink < VccDatabase

  self.table_name = 'link'

  belongs_to :paper, class_name: "LinuxTag::VccPaper", foreign_key: "paper"

end

