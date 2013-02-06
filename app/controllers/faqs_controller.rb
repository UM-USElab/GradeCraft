class FaqsController < ApplicationController
  def index
    @faqs = Faq.all
    respond_with(@faqs)
  end

  def show
    @faq = Faq.find(params[:id])
    respond_with(@faq)
  end

  def new
    @faq = Faq.new
    respond_with(@faq)
  end

  def edit
    @faq = Faq.find(params[:id])
  end

  def create
    @faq = Faq.new(params[:faq])
    @faq.save
    respond_with(@faq)
  end

  def update
    @faq = Faq.find(params[:id])
    @faq.update_attributes(params[:faq])
    respond_with(@faq)
  end

  def destroy
    @faq = Faq.find(params[:id])
    @faq.destroy
    respond_with(@faq)
  end
end
