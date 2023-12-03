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
    @representative = Representative.find(params[:news_item][:representative_id])
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
    article_data = JSON.parse(params[:selected_article])
  
    published_at = if article_data['publishedAt'].present?
                     DateTime.parse(article_data['publishedAt']) rescue DateTime.current
                   else
                     DateTime.current
                   end
  
    rating = params[:news_item][:rating].to_i

    @news_item = NewsItem.new(
      title: article_data['title'],
      link: article_data['url'], 
      description: article_data['description'], 
      rating: rating,
      representative_id: @representative.id,
      created_at: published_at,
      updated_at: DateTime.current,
      issue: params[:news_item][:issue] 
    )
  
    if @news_item.save
      flash[:notice] = 'Article was successfully saved.'
      redirect_to representative_news_items_path(@representative)
    else
      flash[:alert] = 'Error saving article: ' + @news_item.errors.full_messages.join(', ')
      redirect_to representative_news_items_path(@representative)
    end
  end

  private

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def news_item_params
    params.require(:news_item).permit(:news, :title, :description, :link, :representative_id, :issue)
  end

  # make the api request
  def news_api_request(query)
    base_url = 'https://newsapi.org/v2/everything'
    Rails.logger.debug '-----------------'
    query_params = {
      q:      query,
      sortBy: 'relevancy',
      apiKey: Rails.application.credentials[:NEWS_API_KEY]
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