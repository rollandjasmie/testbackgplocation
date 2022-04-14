class OptionsController < ApplicationController
    before_action :set_option, only: [:show, :update, :destroy]
	before_action :authorized,only:[:create,:update,:destroy]

    # GET /categories/:category_id/options
    def index
        category = Category.find(params[:category_id])
        @options = category.options
        json_response(@options)
    end

    # POST /categories/:category_id/options
    def create
        @category = Category.find(params[:category_id])
        @paramsmapped = option_params
        @paramsmapped[:category] = @category
        @option = Option.create!(@paramsmapped)
        json_response(@option, :created)
    end

    # GET /categories/:category_id/options/:id
    def show
        json_response(@option)
    end

    # PUT /categories/:category_id/options/:id
    def update
        category = Category.find(params[:category_id])
        @option.update(option_params)
        head :no_content
    end

    # DELETE /categories/:category_id/options/:id
    def destroy
        @option.destroy
        head :no_content
    end

    private

    def option_params
        # whitelist params
        params.require(:option).permit(:libelle, :prix, :category_id)
    end

    def set_option
        @option = Option.find(params[:id])
    end
end