class Article < ApplicationRecord
  belongs_to :author
  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]


  def tag_list
    tags.join(", ")
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect{|tag| tag.strip.downcase}.uniq
    self.tags = tag_names.collect{|tag_name| Tag.find_or_create_by(name: tag_name)}
  end
end
