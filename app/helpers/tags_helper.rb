module TagsHelper
  def remove_unused_tags
    Tag.all.each do |tag|
      tag.destroy if tag.articles.size == 0
    end
  end
end
