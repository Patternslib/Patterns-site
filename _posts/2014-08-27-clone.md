---
layout: demo
title: Clone
category: behavioural
description: "Pat clone is used to offer users a control to clone (groups of) (form) elements on a page."
properties:
  - property: 'template'
    description: 'Selects the element that will be cloned each time. You might often want to refer to a piece of template markup for this that is hidden with though the CSS.'
    default: '> *:first-child'
    values: 
    type: CSS Selector
  - property: 'max'
    description: 'Maximum number of clones that is allowed'
    default: ''
    type: Integer
  - property: 'trigger-element'
    description: 'Selector of the element that triggers the clone action when clicked upon.'
    default: '.clone-trigger'
    type: CSS selector
---
