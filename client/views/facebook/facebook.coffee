Template.shareit_facebook.rendered = ->
    return unless @data

    @autorun ->
        template = Template.instance()        
        data = Template.currentData()
        
        description = data.facebook?.description || data.excerpt || data.description || data.summary
        url = data.url || location.origin + location.pathname
        title = data.title

        if data.thumbnail
            if typeof data.thumbnail == "function"
                img = data.thumbnail()
            else
                img = data.thumbnail
        if img
            if not /^http(s?):\/\/+/.test(img)
                img = location.origin + img

        #
        # OpenGraph tags
        #
#        $('meta[property^="og:"]').remove()
#        $('<meta>', { property: 'og:type', content: 'article' }).appendTo 'head'
#        $('<meta>', { property: 'og:site_name', content: location.hostname }).appendTo 'head'
#        $('<meta>', { property: 'og:url', content: url }).appendTo 'head'
#        $('<meta>', { property: 'og:title', content: title }).appendTo 'head'
#        $('<meta>', { property: 'og:description', content: description }).appendTo 'head'
#        $('<meta>', { property: 'og:image', content: img }).appendTo 'head'
        
        if ShareIt.settings.sites.facebook.appId?
            template.$('.fb-share').click (e) ->
                e.preventDefault()
                FB.ui {
                    method: 'share'
                    display: 'popup'
                    href: url
                }, (response) ->
        else
            url = encodeURIComponent url
            base = "https://www.facebook.com/sharer/sharer.php"
            title = encodeURIComponent title
            summary = encodeURIComponent description
            href = base + "?m2w&s=100&p[url]=" + url + "&p[title]=" + title + "&p[summary]=" + summary
            if img
                href += "&p[images][0]=" + encodeURIComponent img
    
            template.$(".fb-share").attr "href", href
            
    return
    
Template.shareit_facebook.helpers(ShareIt.helpers)
