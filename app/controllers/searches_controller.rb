class SearchesController < ApplicationController
  def search
    @model = params["model"]
    @content = params["content"]
    @method = params["method"]
    @records = search_for(@model, @content, @method)
  end
  
  private
  def search_for(model, content, method)
    if model == 'user'
      if method == 'forward_match'
        User.where("name LIKE?", "#{content}%")
      elsif method == 'backward_match'
        User.where("name LIKE?", "%#{content}")
      elsif method == 'perfect_match'
        User.where("name LIKE?", "#{content}")
      elsif method == 'partial_match'
        User.where("name LIKE?", "%#{content}%")
      else
        User.all
      end
    elsif model == 'book'
      if method == 'forward_match'
        Book.where("title LIKE?", "#{content}%")
      elsif method == 'backward_match'
        Book.where("title LIKE?", "%#{content}")
      elsif method == 'perfect_match'
        Book.where("title LIKE?", "#{content}")
      elsif method == 'partial_match'
        Book.where("title LIKE?", "%#{content}%")
      else
        Book.all
      end
    end
  end    
        
end