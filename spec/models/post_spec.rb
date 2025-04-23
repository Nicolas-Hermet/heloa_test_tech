require 'rails_helper'

RSpec.describe Post, type: :model do
  # TODO: Maybe discuss the relevance of such tests. I wrote it so I can tell : hey I can spec models and associations.
  #  but clearly, it should be discussed with the team.
  describe 'associations' do
    it { should have_many(:posts_tags).dependent(:destroy) }
    it { should have_many(:tags).through(:posts_tags).dependent(:destroy) }
    it { should have_one(:primary_post_tag).class_name('PrimaryPostsTag').dependent(:destroy) }
    it { should have_one(:primary_tag).through(:primary_post_tag).source(:tag) }
  end

  it 'has a visibility enum' do
    expect(Post.defined_enums['visibility']).to eq({ 'public' => 'public', 'internal' => 'internal' })
    expect(Post.new).to respond_to(:visibility_public?, :visibility_internal?)
  end

  describe 'callbacks' do
    # TODO: Use FactoryBot to build the post instead of creating it directly.
    let(:post) { Post.new(title: 'Test', html: '<p>Content</p>') }
    let(:uuid) { SecureRandom.uuid }

    it 'assigns a uuid before creation if not already set' do
      expect(post.uuid).to be_nil
      post.save!
      expect(post.uuid).to be_present
    end

    it 'does not override an existing uuid' do
      uuid
      post.uuid = uuid
      post.save!
      expect(post.uuid).to eq(uuid)
    end
  end

  describe '.search_by_content_title_and_tags' do
    # TODO: idem here, it would be more simpler with FactoryBot.
    let!(:tag) { Tag.create!(name: 'a', slug: 'random') }
    let!(:post_with_tag) do
      post = Post.create!(title: 'b', html: 'c')
      post.tags << tag
      post
    end
    let!(:other_tag) { Tag.create!(name: 'nope', slug: 'other rndom') }
    let!(:unrelated_post_with_other_tag) do
      post2 = Post.create!(title: 'definitely', html: 'unrelted')
      post2.tags << other_tag
      post2
    end
    let!(:post_without_match) { Post.create!(title: 'Unrelted', html: 'Nothing to see here') }

    it 'returns posts matching title' do
      results = Post.search_by_content_title_and_tags('b')
      expect(results).to include(post_with_tag)
      expect(results).not_to include(unrelated_post_with_other_tag)
    end

    it 'returns posts matching html content' do
      results = Post.search_by_content_title_and_tags('c')
      expect(results).to include(post_with_tag)
      expect(results).not_to include(unrelated_post_with_other_tag)
    end

    it 'returns posts matching associated tags' do
      results = Post.search_by_content_title_and_tags('a')
      expect(results).to include(post_with_tag)
      expect(results).not_to include(unrelated_post_with_other_tag)
    end

    it 'does not return unrelated posts' do
      results = Post.search_by_content_title_and_tags('rails')
      expect(results).not_to include(post_without_match)
    end
  end
end
