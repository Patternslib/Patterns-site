# Comment box

## Description

Comment boxes allow for simple text input with drop down helpers for tagging which may assist users in selecting a tag such as a hash tag or a mentioning a person. 

## Documentation

### Markup

Optically, comment boxes may look identical to regular text areas. Yet if the user enters a tag in the text box, then a helper dropdown list appears which assist the user in (optionally) selecting an existing tag. 

Comment box works on text area elements. Putting class `pat-comment-box` on a text area will convert it into a comment box. 

A tag should always start with a certain 'trigger character'. A typical trigger character for mentioning other users is the @-sign. Use the `trigger-character` property to define the character that should trigger the dropdown list. Illustrated below:

    <textarea class="pat-comment-box" data-pat-comment-box="trigger-character: @"></textarea>

The next thing the pattern needs to know is the location of the feedback list. This location is also the posting address at the same time. This address may or may not be the same as the address of the form action the text area is placed in. Feedback for the list is accepted in json format.

Consider the following example markup:

    <form action="/feedback-page.html">
        <textarea class="pat-comment-box" data-pat-comment-box="trigger-character: @; url: /users.js"></textarea>
        <button type="submit">Post</button>
    </form>
    
An unlimited amount of tag sources is supported. Each source is coupled to one trigger character. Should you want to support for instance mentions and hashtags in one box, then declare multiple sets, separated by `&&`, like in this example: `data-pat-comment-box="trigger-character: @; url: /users.js && trigger-character: #; url: /hash-tags.js"`.
    
### Styling

The markup of the text area is automatically converted into a container element with three child elements:

    <div class="pat-comment-box-container">
        <textarea class="pat-comment-box" data-pat-comment-box="trigger-character: @; url: /users.js"></textarea>
        <p class="pat-comment-box-shadow-content">
        </p>
    </div>

Every text mutation is in realtime copied over to `<p class="pat-comment-box-shadow-content">`. The boilerplate CSS displays this content behind the transparent text area and uses the same font treatment for both elements. This way the illusion is created that one can type and select any text in the text area, without the problems that would come with a rich editor such as less clean markup after pasting rich text. 

Any text string that starts with a trigger character is spanned in the shadow content (not in the text area content). For example: 

    <p class="pat-comment-box-shadow-content">
        I'm so happy to use <span class="tag">#patternslib</span>!
    </p>
    
The span is closed before the next space or interpunction character. 

These spans are used for colour coding the tags in the content.





