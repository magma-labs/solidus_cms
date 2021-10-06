# frozen_string_literal: true

module Cms
  class YoutubeVideoPresenter < ComponentsBasePresenter
    def defaults
      { height: 400, width: 560 }
    end

    def youtube_url
      "https://www.youtube.com/embed/#{object.youtube_video_id}"
    end
  end
end
