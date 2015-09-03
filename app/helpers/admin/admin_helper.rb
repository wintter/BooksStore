module Admin::AdminHelper

  def flash_and_redirect(entity, type)
    if entity.kind_of? Author
      flash[:success] = 'Author ' << entity.firstname
    elsif entity.kind_of? Book
      flash[:success] = 'Book ' << entity.title
    elsif entity.kind_of? Category
      flash[:success] = 'Category ' << entity.title
    elsif entity.kind_of? Order
      flash[:success] = 'Order has successfully updated'
    else
      flash[:success] = 'Review has successfully approved'
    end
    if type.eql? 'create'
      flash[:success] << ' has successfully created'
    elsif type.eql? 'update'
      flash[:success] << ' has successfully updated'
    end
    redirect_to action: 'index'
  end

end
