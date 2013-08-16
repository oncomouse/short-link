ShortLinks::Admin.controllers :shorties do
  get :index do
    @title = "Shorties"
    @shorties = Shorty.all
    render 'shorties/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'shorty')
    @shorty = Shorty.new
    render 'shorties/new'
  end

  post :create do
    @shorty = Shorty.new(params[:shorty])
    if @shorty.save
      @title = pat(:create_title, :model => "shorty #{@shorty.id}")
      flash[:success] = pat(:create_success, :model => 'Shorty')
      params[:save_and_continue] ? redirect(url(:shorties, :index)) : redirect(url(:shorties, :edit, :id => @shorty.id))
    else
      @title = pat(:create_title, :model => 'shorty')
      flash.now[:error] = pat(:create_error, :model => 'shorty')
      render 'shorties/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "shorty #{params[:id]}")
    @shorty = Shorty.get(params[:id])
    if @shorty
      render 'shorties/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'shorty', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "shorty #{params[:id]}")
    @shorty = Shorty.get(params[:id])
    if @shorty
      if @shorty.update(params[:shorty])
        flash[:success] = pat(:update_success, :model => 'Shorty', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:shorties, :index)) :
          redirect(url(:shorties, :edit, :id => @shorty.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'shorty')
        render 'shorties/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'shorty', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Shorties"
    shorty = Shorty.get(params[:id])
    if shorty
      if shorty.destroy
        flash[:success] = pat(:delete_success, :model => 'Shorty', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'shorty')
      end
      redirect url(:shorties, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'shorty', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Shorties"
    unless params[:shorty_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'shorty')
      redirect(url(:shorties, :index))
    end
    ids = params[:shorty_ids].split(',').map(&:strip)
    shorties = Shorty.all(:id => ids)
    
    if shorties.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Shorties', :ids => "#{ids.to_sentence}")
    end
    redirect url(:shorties, :index)
  end
end
