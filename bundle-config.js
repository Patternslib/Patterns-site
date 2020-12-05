/* Patterns bundle configuration. */
import "./public_path"; // first import
import "modernizr";

// Core
import jquery from "jquery";
import registry from "patternslib/src/core/registry";

// Pattern imports
import "pat-content-mirror/src/pat-content-mirror";
import "pat-sortable-table/src/pat-sortable-table";
import "pat-upload/src/pat-upload";
import "patternslib/src/pat/ajax/ajax";
import "patternslib/src/pat/auto-scale/auto-scale";
import "patternslib/src/pat/auto-submit/auto-submit";
import "patternslib/src/pat/auto-suggest/auto-suggest";
import "patternslib/src/pat/autofocus/autofocus";
import "patternslib/src/pat/breadcrumbs/breadcrumbs";
import "patternslib/src/pat/bumper/bumper";
import "patternslib/src/pat/calendar/calendar";
import "patternslib/src/pat/carousel/carousel";
import "patternslib/src/pat/checklist/checklist";
import "patternslib/src/pat/clone/clone";
import "patternslib/src/pat/collapsible/collapsible";
import "patternslib/src/pat/colour-picker/colour-picker";
import "patternslib/src/pat/date-picker/date-picker";
import "patternslib/src/pat/depends/depends";
import "patternslib/src/pat/display-time/display-time";
import "patternslib/src/pat/equaliser/equaliser";
import "patternslib/src/pat/expandable-tree/expandable-tree";
import "patternslib/src/pat/focus/focus";
import "patternslib/src/pat/form-state/form-state";
import "patternslib/src/pat/forward/forward";
import "patternslib/src/pat/fullscreen/fullscreen-close";
import "patternslib/src/pat/fullscreen/fullscreen";
import "patternslib/src/pat/gallery/gallery";
import "patternslib/src/pat/image-crop/image-crop";
import "patternslib/src/pat/inject/inject";
import "patternslib/src/pat/legend/legend";
import "patternslib/src/pat/markdown/markdown";
import "patternslib/src/pat/masonry/masonry";
import "patternslib/src/pat/menu/menu";
import "patternslib/src/pat/modal/modal";
import "patternslib/src/pat/navigation/navigation";
import "patternslib/src/pat/notification/notification";
import "patternslib/src/pat/scroll-box/scroll-box";
import "patternslib/src/pat/scroll/scroll";
import "patternslib/src/pat/selectbox/selectbox";
import "patternslib/src/pat/sortable/sortable";
import "patternslib/src/pat/stacks/stacks";
import "patternslib/src/pat/sticky/sticky";
import "patternslib/src/pat/subform/subform";
import "patternslib/src/pat/switch/switch";
import "patternslib/src/pat/syntax-highlight/syntax-highlight";
import "patternslib/src/pat/tabs/tabs";
import "patternslib/src/pat/toggle/toggle";
import "patternslib/src/pat/tooltip/tooltip";
import "patternslib/src/pat/validation/validation";

window.jQuery = jquery;
registry.init();


// not yet included:
//import "pat-ckeditor/src/ckeditor";
//import "pat-content-mirror/src/pat-content-mirror";
//import "pat-doclock/src/pat-doclock";
//import "pat-redactor/src/pat-redactor";
//import "pat-shopping-cart/src/pat-shopping-cart";
//import "pat-sortable-table/src/pat-sortable-table";
//import "pat-tiptap/src/tiptap";
//import "pat-upload/src/pat-upload";
//import "patternslib/src/pat/push/push";
//import "patternslib/src/pat/slides/slides";
//import "patternslib/src/pat/zoom/zoom";

