module ApplicationHelper
  # Returns the full title on a per-page basis.       # Documentation comment
   def full_title(page_title)                          # Method definition
     base_title = t("Brandname")  # Variable assignment
     if page_title.empty?                              # Boolean test
       base_title                                      # Implicit return
     else
       "#{page_title} | #{base_title}"                 # String interpolation
     end
   end
  # Prepends locale to url in link if not english, useful if routing-filter not works (=rails_admin)
   def locale_url_for(*args)
    unless !locale || locale == 'en'
      url_for(*args).sub('/', "/#{locale}/")
    else
      url_for(*args)
    end
   end
   def localizing_path(path)
    unless !locale || locale == 'en'
      path.sub('/', "/#{locale}/")
    else
      path
    end
   end
end
