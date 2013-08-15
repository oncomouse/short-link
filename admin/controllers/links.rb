ShortLinks::Admin.controllers :links do
  get :index do
    @title = "Links"
    @links = Link.all
    render 'links/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'link')
    @link = Link.new
    render 'links/new'
  end

  post :create do
    @link = Link.new(params[:link])
    if @link.save
      @title = pat(:create_title, :model => "link #{@link.id}")
      flash[:success] = pat(:create_success, :model => 'Link')
      params[:save_and_continue] ? redirect(url(:links, :index)) : redirect(url(:links, :edit, :id => @link.id))
    else
      @title = pat(:create_title, :model => 'link')
      flash.now[:error] = pat(:create_error, :model => 'link')
      render 'links/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "link #{params[:id]}")
    @link = Link.get(params[:id])
    if @link
      render 'links/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'link', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "link #{params[:id]}")
    @link = Link.get(params[:id])
    if @link
      if @link.update(params[:link])
        flash[:success] = pat(:update_success, :model => 'Link', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:links, :index)) :
          redirect(url(:links, :edit, :id => @link.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'link')
        render 'links/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'link', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Links"
    link = Link.get(params[:id])
    if link
      if link.destroy
        flash[:success] = pat(:delete_success, :model => 'Link', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'link')
      end
      redirect url(:links, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'link', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Links"
    unless params[:link_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'link')
      redirect(url(:links, :index))
    end
    ids = params[:link_ids].split(',').map(&:strip)
    links = Link.all(:id => ids)
    
    if links.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Links', :ids => "#{ids.to_sentence}")
    end
    redirect url(:links, :index)
  end
end
