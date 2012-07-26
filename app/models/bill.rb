class Bill < Category
  validates :title, presence: true, uniqueness: false
end