class TestController < ApplicationController

    def index
        
        @testvar = 'hey there!'
        #render layout: false
        #render html: "<strong>Not Found</strong>".html_safe#, layout: false
    end

end