module BuildsHelper
    def format_revision(revision)
        if revision.respond_to? :format_identifier
          revision.format_identifier
        else
          revision.to_s
        end
      end
    
end
