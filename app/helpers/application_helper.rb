module ApplicationHelper

    def full_title(page_title = '')
        base_title = "Ruby on Rails Tutorial Sample App"
        if page_title.empty?
          base_title
        else
          page_title + " | " + base_title
        end
      end



      def rating(stars)
        tot=0.0
        u=0
        stars.each do |star|
          tot=tot+star.star
          u=u+1
        end
        rat=tot/u
        s='%.2f' % rat
        if(rat>0)
        content_tag(:h4, s)
        else
          content_tag(:h4, 0)
        end

      end

      def star_rating(stars)
        tot=0.0
        u=0
        stars.each do |star|
          tot=tot+star.star
          u=u+1
        end
        rat=tot/u
        s=rat.to_i
       
          return s
        
       

      end
end
