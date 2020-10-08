class ArtistController < ApplicationController

    get '/artists' do 
        if   !logged_in?
            redirect to '/login'
        else
            @artists = @current_user.artists
            erb :'artists/index'       
        end
    end

    get '/artists/new' do 
        if !logged_in?
            redirect '/login' 
        else
            erb :'artists/new'
        end
    end
    
    post '/artists' do 
        if !logged_in?
            redirect to "/login"
        else
            @artist = Artist.new(name: params[:name],notes: params[:notes])    
            @current_user.artists << @artist 
        if
            @artist.save
            redirect "/artists/show"
        else 
            redirect to "/artists/new"
        end
        end
    end

    get '/artists/:id' do
        if !logged_in?
           redirect '/login' 
        else
            @artist = Artist.find_by(id: params[:id])
        end
        if @artist
        
            erb :'/artists/show'
        else
            redirect '/artists'
        end
    end

    get '/artists/:id/edit' do 
        @artist = Artist.find(params[:id])
        erb :'artists/edit'
    end

    patch '/artists/:id' do
        @artist = Artist.find(params[:id])
        if @artist.update(params[:artist])
            redirect to "/artists/#{@artist.id}"
        else
            erb :"artists/edit"
        end
    end

    delete '/artists/:id' do
        @artist = Artist.delete(params[:id])
        redirect '/artists'
    end
end