class BlogCategory < ApplicationRecord
  has_and_belongs_to_many	:blog_posts
  belongs_to :genre
  before_save	:set_slug

  def set_slug
    self.slug = name.parameterize
  end

  def self.update_counts(blog_post)
    includes(:blog_posts).where(blog_posts: { id: blog_post.id }).each(&:update_posts_count)
  end

  def update_posts_count
    self.blog_post_count = blog_posts.count
    save!
  end

  def nice_name
    name.capitalize
  end
end
