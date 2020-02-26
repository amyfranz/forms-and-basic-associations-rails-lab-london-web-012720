class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new
    @genre = Genre.all
  end

  def create
    
    song = Song.new
    song.title = params[:song_title]
    song.genre_id = params[:song][:genre_id]
    song.artist_id = Artist.find_or_create_by(name: "#{params[:song_artist_name]}").id
    if song.save
      note = Note.create(content: params[:song_notes_attributes_0_content], song_id: song.id)
      note2 = Note.create(content: params[:song_notes_attributes_1_content], song_id: song.id)
      redirect_to song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title)
  end
end

