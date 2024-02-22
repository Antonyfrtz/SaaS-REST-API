$(document).on('turbo:load', function() { 

    // when conversation heading is clicked, toggle conversation
    $('body').on('click', 
    	         '.conversation-heading, .conversation-heading-full', 
    	         function(e) {
        e.preventDefault();
        var panel = $(this).parent();
        var panel_body = panel.find('.panel-body');
        var messages_list = panel.find('.messages-list');
        var conversation_heading;

        panel_body.toggle(100, function() {
            var messages_visible = $('ul', this).has('li').length;
            // if window is collapsed, hide conversation menu options
            if ( panel_body.css('display') == 'none' ) {
                panel.find('.add-people-to-chat,\
                            .add-user-to-contacts,\
                            .contact-request-sent').hide();
                conversation_heading = panel.find('.conversation-heading');
                conversation_heading.css('width', '360px');

            } else { // show conversation menu options
                conversation_heading = panel.find('.conversation-heading');
                conversation_heading.css('width', '320px');
                panel.find('.add-people-to-chat,\
                            .add-user-to-contacts,\
                            .contact-request-sent').show();
                // focus textarea
                $('form textarea', this).focus();
            }
        
            // Load first 10 messages if messages list is empty
            if (!messages_visible && $('.load-more-messages', this).length) {
                $('.load-more-messages', this)[0].click(); 
            }
        }); 
    });
});