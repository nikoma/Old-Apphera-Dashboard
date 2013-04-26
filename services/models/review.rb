class Review < ActiveRecord::Base
  #after_save :calculate_reviewer_stats, :update_org_reviewers_list

#  include Tire::Model::Search
#  include Tire::Model::Callbacks
  belongs_to :organization
  belongs_to :content_provider
  belongs_to :reviewer
  validates_uniqueness_of :review_provider_id
  validates :organization_id, :presence => true

 # Tire.configure do
#    url Appheradashboard::Application::CONFIG[:tire_ip]
 # end
  # define_index do
  #     indexes body
  #     indexes title
  #     indexes organization(:name), :as => :org
  #     has organization_id, reviewer_id, created_at, rating
  #     end
  #        

  # define_index do
  #               indexes body
  #               indexes title
  #               indexes organization.id, :as :organization_id
  #               indexes content_provider.name, :as :content_provider_name
  #               indexes reviewer.name, :as :reviewer_name
  #             end
  def self.paginate(options = {})
    page(options[:page]).per(options[:per_page])
  end


 # def self.all_reviews(org_id)
 #   tire.search(per_page: 100) do
 #     query do
 #       string "organization_id:#{org_id}"
 #     end
 #   end
 # end

 # def self.search(params, org_id)
 #   tire.search(page: params[:page], per_page: 5) do
 #     query do
 #       boolean do
 #         must { string "body:#{params[:query]}" }
 #         must { string "organization_id:#{org_id}" }
 #         sort { by :created_at, "desc" } if params[:query].blank?
#
#        end
#      end
#    end
#  end

 # def self.search2(params, org_id, p=0)
 #   tire.search(load: true, page: p) do
 #     query do
 #       boolean do
 #         must { string "body:#{params}" }
 #         must { string "organization_id:#{org_id}" }
 #       end
 #     end
      #   raise to_curl
 #   end
 # end

 # def to_index_json
 #   to_json(methods: [:reviewer_name, :organization_name])
 # end

  def reviewer_name
    reviewer.name
  end

  def organization_name
    organization.name
  end

  def calculate_reviewer_stats
    reviewer = self.reviewer
    if reviewer.average_review == nil
      reviewer.average_review = 0.0
    end
    if reviewer.review_count == nil
      reviewer.review_count = 0
    end
    old_avg = reviewer.average_review #* reviewer.review_count
    reviewer.review_count += 1
    reviewer.average_review = old_avg + self.rating / reviewer.review_count
    reviewer.save
  end

  def update_org_reviewers_list
    lr = organization.list_of_reviewers
    organization.reviewers_list << self.reviewer_id
    organization.save
  end

end
