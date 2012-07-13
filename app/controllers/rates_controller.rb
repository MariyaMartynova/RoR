class RatesController < ApplicationController
  def index
    @product=Product.find(params[:product_id])
    @rates = @product.rates

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rates }
    end
  end

  def create
    @product=Product.find(params[:product_id])
    @rate=@product.rates.create(params[:rate]) unless @rate=Rate.find_by_product_id(@product.id)
     rate=@rate.rate+1
     @rate.update_attributes(:rate=>rate)
    respond_to do |format|
      if @rate
        
        format.html { redirect_to(@product, :notice => 'Comment was successfully created.') }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
        format.js 
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
  end

end
