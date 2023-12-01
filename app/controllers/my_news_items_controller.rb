# frozen_string_literal: true

class MyNewsItemsController < SessionController
  before_action :set_representative
  before_action :set_representatives_list
  before_action :set_news_item, only: %i[edit update destroy]

  def new
    @news_item = NewsItem.new
  end

  def edit; end

  def search_news_items
    @representative = Representative.find(params[:representative_id])
    @selected_issue = params[:news_item][:issue]
    @articles = news_api_request("#{@representative.name} #{@selected_issue}").first(5)
    render 'search_results'
  end

  def create
    @news_item = NewsItem.new(news_item_params)
    if @news_item.save
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      render :new, error: 'An error occurred when creating the news item.'
    end
  end

  def update
    if @news_item.update(news_item_params)
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully updated.'
    else
      render :edit, error: 'An error occurred when updating the news item.'
    end
  end

  def destroy
    @news_item.destroy
    redirect_to representative_news_items_path(@representative),
                notice: 'News was successfully destroyed.'
  end

  def save_article
    news_item = NewsItem.find_by(id: params[:selected_article])
    #flash[:notice] = "Saved article '#{params[:selected_article]}'"
    if news_item
      rating = news_item.ratings.create(
        score: params[:article_rating],
        representative: @representative
      )
      if rating.persisted?
        flash[:notice] = "Saved article '#{news_item.title}' with rating #{rating.score}."
      else
        flash[:alert] = "Failed to save rating."
      end
    else
      flash[:alert] = "Article not found."
    end
  
    redirect_to representative_news_items_path(@representative)
  end
  
  private

  def set_representative
    @representative = Representative.find(params[:representative_id])
  end

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  def news_item_params
    params.require(:news_item).permit(:news, :title, :description, :link, :representative_id, :issue, :selected_article, :article_rating)
  end

  # make the api request
  def news_api_request(query)
    base_url = 'https://newsapi.org/v2/everything'
    Rails.logger.debug '-----------------'
    query_params = {
      q:      query,
      sortBy: 'relevancy',
      apiKey: "ff48d2ce0dbc4d5d9ecdc05c214a9df9"
      #Rails.application.credentials[:NEWS_API_KEY]
    }

    api_url = URI.parse("#{base_url}?#{URI.encode_www_form(query_params)}")

    http = Net::HTTP.new(api_url.host, api_url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(api_url.request_uri)

    response = http.request(request)

    if response.code.to_i == 200
      JSON.parse(response.body)['articles']
    else
      Rails.logger.debug { "Error: #{response.code} - #{response.message}" }
      nil
    end
  end
end
