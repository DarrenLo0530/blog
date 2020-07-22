class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings, dependent: :destroy

  def tag_list
    tags.join(", ")
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect{|tag| tag.strip.downcase}.uniq
    self.tags = tag_names.collect{|tag_name| Tag.find_or_create_by(name: tag_name)}
  end
end
