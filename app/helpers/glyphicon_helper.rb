# app/helpers/my_custom_helper.rb
include ActionView::Helpers::TagHelper

module GlyphiconHelper
  def glyph params
    if params.class == Symbol
      glyph = params
      text = ''
      glyphicon_class = 'glyphicon glyphicon-' + glyph.to_s
    else
      text = params[:text] || ''
      glyph = params[:glyph]
      url = params[:url]
      glyphicon_class = 'glyphicon glyphicon-' + glyph.to_s
    end
    html = content_tag(:i, text, :class=>glyphicon_class)
    (html = link_to html, url) if url.present?
    html
  end

end
