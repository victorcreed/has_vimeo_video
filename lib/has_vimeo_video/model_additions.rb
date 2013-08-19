module HasVimeoVideo
  module ModelAdditions

    def has_vimeo_video(attribute, options = nil)
      message = (options and options[:message]) || "only Vimeo OR Youtube URLs are allowed"
      validates_format_of attribute, with: HasVimeoVideo::VimeoVideo.regex_custom, message: message, allow_nil: true, allow_blank: true
      self.class_eval <<-EOF
        def vimeo
          return @vimeo if @vimeo
          @vimeo = HasVimeoVideo::VimeoVideo.new self.#{attribute}
        end
      EOF
    end
        
  end
end
