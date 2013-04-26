class Tweet < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
  belongs_to :twitter_user
  validates_uniqueness_of :tweet_id
  
  Tire.configure do
      url Appheradashboard::Application::CONFIG[:tire_ip]
    end
  
  def self.paginate(options = {})
        page(options[:page]).per(options[:per_page])
      end
      def search(params)
          tire.search(page: params[:page],load: true) do
            query { string params[:query], default_operator: "AND" } if params[:query].present?
          end
      end
  #tire do
  #  mapping do
  #    indexes :content, type: 'string', analyzer: 'snowball'
  #    indexes :name, type: 'string', analyzer: 'keyword'
  #    indexes :screen_name, type: 'string', analyzer: 'keyword'
  #    indexes :twitter_image, type: 'string', analyzer: 'snowball'
  #  end
  #end
        def to_index_json
            to_json(methods: [:twitter_user_name])
          end      

      def twitter_user_name
        twitter_user.scree_name
      end
      #def twitter_image
      #  twitter_user.image_url
      #end
      #def twitter_language
      #  twitter_user.language
      #end
      #def twitter_statuses
      #  twitter_user.total_statuses
      #end
 
end
