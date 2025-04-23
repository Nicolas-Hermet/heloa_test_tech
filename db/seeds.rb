# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# destroy every object and reset pk sequence
# TODO: loop through ActiveRecord::Base.connection.tables
PrimaryPostsTag.destroy_all
PostsTag.destroy_all
Tag.destroy_all
Post.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('tags')
ActiveRecord::Base.connection.reset_pk_sequence!('posts')
ActiveRecord::Base.connection.reset_pk_sequence!('primary_posts_tags')
ActiveRecord::Base.connection.reset_pk_sequence!('post_tags')

json = JSON.parse(File.read(Rails.root.join("db/articles_simplified.json"))) # TODO: Dynamically handle the folder(s
json['posts'].each do |post_data|
  current_post = Post.find_or_create_by!(uuid: post_data["uuid"]) do |post|
    post.title = post_data['title'],
    post.slug = post_data['slug'],
    post.html = post_data['html'],
    post.feature_image = post_data['feature_image'],
    post.featured = post_data['featured'],
    post.published_at = post_data['published_at'],
    post.custom_excerpt = post_data['custom_excerpt'],
    post.excerpt = post_data['excerpt'],
    post.reading_time = post_data['reading_time'],
    post.access = post_data['access'],
    post.comments = post_data['comments'],
    post.og_image = post_data['og_image'],
    post.og_title = post_data['og_title'],
    post.og_description = post_data['og_description'],
    post.twitter_image = post_data['twitter_image'],
    post.twitter_title = post_data['twitter_title'],
    post.twitter_description = post_data['twitter_description'],
    post.meta_title = post_data['meta_title'],
    post.meta_description = post_data['meta_description'],
    post.email_subject = post_data['email_subject'],
    post.frontmatter = post_data['frontmatter'],
    post.feature_image_alt = post_data['feature_image_alt'],
    post.feature_image_caption = post_data['feature_image_caption'],
    post.created_at = post_data['created_at'],
    post.updated_at = post_data['updated_at'],
    post.visibility = post_data['visibility']
  end
  post_data["tags"].each do |tag_data|
    next if tag_data['name'].start_with?("#")

    current_post.tags << Tag.find_or_create_by!(slug: tag_data["slug"]) do |tag|
      tag.name = tag_data['name']
      tag.description = tag_data['description']
      tag.feature_image = tag_data['feature_image']
      tag.visibility = tag_data['visibility']
      tag.og_image = tag_data['og_image']
      tag.og_title_string = tag_data['og_title']
      tag.meta_title = tag_data['meta_title']
      tag.meta_description = tag_data['meta_description']
      tag.url = tag_data['url']
    end
  end

  PrimaryPostsTag.create!(
    post: current_post,
    tag: Tag.find_or_create_by!(slug: post_data['primary_tag']['slug']) do |tag|
      tag.name = post_data['primary_tag']['name']
      tag.description = post_data['primary_tag']['description']
      tag.feature_image = post_data['primary_tag']['feature_image']
      tag.visibility = post_data['primary_tag']['visibility']
      tag.og_image = post_data['primary_tag']['og_image']
      tag.og_title_string = post_data['primary_tag']['og_title']
      tag.meta_title = post_data['primary_tag']['meta_title']
      tag.meta_description = post_data['primary_tag']['meta_description']
      tag.url = post_data['primary_tag']['url']
    end
  ) if post_data['primary_tag'] && !post_data['primary_tag']['name'].start_with?('#')
end
