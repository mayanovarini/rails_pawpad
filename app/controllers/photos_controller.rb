class PhotosController < ApplicationController

  def destroy
    @photo = Photo.find(params[:id])
    pad = @photo.pad

    @photo.destroy
    @photos = Photo.where(pad_id: pad.id)

    respond_to :js
  end
end
