class AddIndexBodyToReviews < ActiveRecord::Migration
  def change
    execute "create index review_body on reviews using gin(to_tsvector('english', body))"
  end
end
