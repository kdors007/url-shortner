class UrlsController < ApplicationController
	
	def index
		@urls = Url.all
	end

	def show
		@url = Url.find(params[:id])
		goto = @url.link
		if goto.downcase.exclude?('http://')
			redirect_to "http://www.#{goto}"
		else
			redirect_to goto
		end
	end

	def new
		@url = Url.new
	end

	def edit
		@url = Url.find(params[:id])
	end

	def create
		@url = Url.new(url_params)

		if @url.save
			redirect_to urls_path
		else
			render 'index'
		end
	end

	def update
		@url = Url.find(params[:id])

		if @url.update(url_params)
			redirect_to @url
		else
			render 'edit'
		end
	end

	def destroy
		@url = Url.find(params[:id])
		@url.destroy

		redirect_to urls_path
	end

	private
		def url_params
			params.require(:url).permit(:link)
		end

end
