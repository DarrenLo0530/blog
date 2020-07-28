class LinkCommentToAuthor < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :author_name
    add_reference :comments, :author, foreign_key: true
  end
end
