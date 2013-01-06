/*
  Client Side Validations - SimpleForm - v2.0.0
  https://github.com/dockyard/client_side_validations-simple_form

  Copyright (c) 2012 DockYard, LLC
  Licensed under the MIT license
  http://www.opensource.org/licenses/mit-license.php
*/
(function(){ClientSideValidations.formBuilders["SimpleForm::FormBuilder"]={add:function(e,t,n){return this.wrappers[t.wrapper].add.call(this,e,t,n)},remove:function(e,t){return this.wrappers[t.wrapper].remove.call(this,e,t)},wrappers:{"default":{add:function(e,t,n){var r,i;return r=e.parent().find(""+t.error_tag+"."+t.error_class),i=e.closest(t.wrapper_tag),r[0]==null&&(r=$("<"+t.error_tag+"/>",{"class":t.error_class,text:n}),i.append(r)),i.addClass(t.wrapper_error_class),r.text(n)},remove:function(e,t){var n,r;return r=e.closest(""+t.wrapper_tag+"."+t.wrapper_error_class),r.removeClass(t.wrapper_error_class),n=r.find(""+t.error_tag+"."+t.error_class),n.remove()}},bootstrap:{add:function(e,t,n){var r,i,s;return r=e.parent().find(""+t.error_tag+"."+t.error_class),r[0]==null&&(s=e.closest(t.wrapper_tag),r=$("<"+t.error_tag+"/>",{"class":t.error_class,text:n}),s.append(r)),i=e.closest("."+t.wrapper_class),i.addClass(t.wrapper_error_class),r.text(n)},remove:function(e,t){var n,r,i;return r=e.closest("."+t.wrapper_class+"."+t.wrapper_error_class),i=e.closest(t.wrapper_tag),r.removeClass(t.wrapper_error_class),n=i.find(""+t.error_tag+"."+t.error_class),n.remove()}}}}}).call(this);